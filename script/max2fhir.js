const fs = require('fs'),
    xml2js = require('xml2js');
const xml = new xml2js.Parser();
//
// BASE_CANONICAL is the canonical of the base model from the IG.dependsOn!
// Also update ig.ini when PACKAGE_ID changes
//
const MAX_FILE = "script/medlist.max";
const BASE_CANONICAL = "http://hl7.org/ehrs/uv/phrsfmr2";
const BASE_CANONICAL_PREFIX = BASE_CANONICAL + "/Requirements/PHRSFMR2-"
const CANONICAL = "http://hl7.org/ehrs/us/medlistfp";
const PACKAGE_ID = "hl7.ehrs.us.medlistfp";
const STANDARDS_STATUS = "informative";
const FMID_PREFIX = "MEDLISTFP";

var maxroot;
var raw = fs.readFileSync(MAX_FILE, "utf8");
// raw = raw.replace(/[‘’]/g,"'").replace(/[“”]/g,'"'); // replace special quote
// raw = raw.replace(/[–]/g,'-'); // replace special dash
raw = raw.replaceAll('',''); // Jekyll illegal char (tab) in TI.1.8.1
xml.parseString(raw, function (err, data) {
    maxroot = data;
});
// The order in the base model is wrong in some places e.g. RI.1.1.25 criteria come before the function.
// Fix the order.
sort(maxroot);

var rawSatisfiedBy = fs.readFileSync("script/satisfiedBy.txt").toString();
var satisfiedBy = {};
rawSatisfiedBy.split('\n').forEach(row => {
    var idx = row.indexOf(',');
    var id = row.substring(0, idx);
    var uri = row.substring(idx+1);
    satisfiedBy[id] = uri;
});

var groupings = [ ];
var resources = [ ];
var reqs = { };

maxroot.model.objects.forEach(_temp => {
    _temp.object.forEach(object => {
        var parentObject;
        var fhir_parent_req;
        if (object.parentId) {
            parentObject = _temp.object.find(object2 => object2.id[0] == object.parentId[0]);
            fhir_parent_req = reqs[object.parentId[0]];
        }

        var fhir_req;
        switch (object.stereotype[0]) {
            // TODO: profiles not yet handled differently
            // - should accomodate for (statement.)derivedFrom relationship with base
            // - and somehow make really visible what was changed in this profile!
            case "HL7-FM-Profile":
            case "HL7-FM":
                fhir_req = handleFM(object, parentObject);
                break;
            case "Section":
                fhir_req = handleSection(object, parentObject);
                break;
            case "Header":
            case "Function":
                fhir_req = handleHeaderOrFunction(object, parentObject);
                break;
            case "Criteria":
                handleCriteria(object, fhir_parent_req);
                break;
            default:
                break;
        }
        if (fhir_req) {
            reqs[object.id[0]] = fhir_req;
        }
    });
});

Object.values(reqs).forEach(req => {
    var filename = "input/resources/Requirements-" + req.id + ".json";
    console.log(filename);
    // console.log(JSON.stringify(req, null, 2));
    fs.writeFileSync(filename, JSON.stringify(req, null, 2))
});

sortResources();
var grouping = {
    "id": "OTH",
    "name" : "Other",
    "description" : ""
}
groupings.push(grouping);

// create ig.json from template
var template_filename = "script/ig-template.json";
var ig_json = fs.readFileSync(template_filename, 'utf8');
ig_json = ig_json.replace("$GROUPINGS$", JSON.stringify(groupings, null, 2));
ig_json = ig_json.replace("$RESOURCES$", JSON.stringify(resources, null, 2));
ig_json = ig_json.replaceAll("$CANONICAL$", CANONICAL);
ig_json = ig_json.replaceAll("$PACKAGE_ID$", PACKAGE_ID);
ig_json = ig_json.replaceAll("$FMID_PREFIX$", FMID_PREFIX);
ig_json = ig_json.replaceAll("$STANDARDS_STATUS$", STANDARDS_STATUS);

var filename = `input/ImplementationGuide-${PACKAGE_ID}.json`;
fs.writeFileSync(filename, ig_json);

function handleFM(fm) {
    var title = fm.name[0];
    var name = title.replace(/[^A-Za-z0-9_]/g, '_');
    // var notes = fm.notes[0];

    var fhir_req = {
        "resourceType": "Requirements",
        "id": FMID_PREFIX,
        "meta": {
            "profile": [
                `${BASE_CANONICAL}/StructureDefinition/FunctionalModel`
            ]
        },
        "extension": [
            {
                "url": `http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status`,
                "valueCode": STANDARDS_STATUS
            }
        ],
        // "url": `${BASE}/Requirements/` + fmid,
        "name": name,
        "title": title,
        "status": "active",
        "description": "*intentionally left blank*"
    };

    var resource = {
        "reference": { "reference": `Requirements/${FMID_PREFIX}` },
        "isExample": false,
        "groupingId": "OTH"
    }
    resources.push(resource);

    return fhir_req;
}

function handleSection(section, parentObject) {
    var title = section.name[0];
    // Names should be computer friendly
    var name = title.replace(/[^A-Za-z0-9_]/g, '_');
    var alias = section.alias[0];
    var notes = section.notes[0];
    var ovidx = notes.indexOf("$OV$"); // always 4
    var exidx = notes.indexOf("$EX$");
    var acidx = notes.indexOf("$AC$");
    var overview = notes.substring(4, exidx).trim();
    var example = notes.substring(exidx+4, acidx).trim();
    var actors = notes.substring(acidx+4).trim();
    var _description = overview + (example!=""?`\n\nExample(s):\n${example}`:"");

    var fhir_section = {
        "resourceType": "Requirements",
        "id": `${FMID_PREFIX}-${alias}`,
        "meta": {
            "profile": [
                `${BASE_CANONICAL}/StructureDefinition/FMSection`
            ]
        },
        "extension": [
            {
                "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
                "valueCode": STANDARDS_STATUS
            },
            {
                "url": `${BASE_CANONICAL}/StructureDefinition/requirements-actors`,
                "valueString": actors
            }
        ],
        // "url": "http://hl7.org/fhir/Requirements/" + fmid + "-" + alias,
        "name": name,
        "title": title,
        "status": "active",
        "description": _description
    }
    // remove extension if there is no actors
    if (actors == "") {
        delete fhir_section.extension;
    }
    var grouping = {
        "id": alias,
        "name" : title + " Section",
        "description" : overview
    }
    groupings.push(grouping);

    var resource = {
        "reference": { "reference": `Requirements/${FMID_PREFIX}-${alias}` },
        "isExample": false,
        "groupingId": "OTH"
    }
    resources.push(resource);
 
    return fhir_section;
}

function handleHeaderOrFunction(headerOrFunction, parentObject) {
    // some assertions
    if (headerOrFunction.notes == undefined) {
        console.error("HeaderOrFunction without notes? " + JSON.stringify(headerOrFunction));
        return;
    }

    // There are names with a '&', that gives issues in Jekyll? In title they need to be html escaped.
    var title = headerOrFunction.name[0];
    // Names should be computer friendly
    var name = headerOrFunction.name[0].replace(/[^A-Za-z0-9_]/g, '_');
    var alias = headerOrFunction.alias[0];
    var notes = headerOrFunction.notes[0];
    var stidx = notes.indexOf("$ST$");
    var deidx = notes.indexOf("$DE$");
    var exidx = notes.indexOf("$EX$");
    if (exidx == -1) exidx = notes.length;
    var statement = notes.substring(4, deidx).trim();
    var description = notes.substring(deidx+4, exidx).trim();
    var example = notes.substring(exidx+4).trim();
    var type = headerOrFunction.stereotype[0];
    description = description + (example!=""?`\n\nExample(s):\n${example}`:"");
    // replace special link notation '[[{id}]]' with markdown link
    description = description.replace(/\[\[([^\]]+)\]\]/g, `[\$1](Requirements-${FMID_PREFIX}-\$1.html)`);
    const refAlias = headerOrFunction.tag.find(tag => tag['$'].name === 'Reference.Alias');
    const refFunctionID = headerOrFunction.tag.find(tag => tag['$'].name === 'Reference.FunctionID');
    const refChangeInd = headerOrFunction.tag.find(tag => tag['$'].name === 'Reference.ChangeIndicator');

    var fhir_headerOrFunction = {
        "resourceType": "Requirements",
        "id": `${FMID_PREFIX}-${alias}`,
        "meta": {
            "profile": [
                `${BASE_CANONICAL}/StructureDefinition/FM${type}`
            ]
        },
        "extension": [
            {
                "url": "http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status",
                "valueCode": STANDARDS_STATUS
            }
        ],
        // "url": `http://hl7.org/fhir/Requirements/${fmid}-${alias}`,
        "name": name,
        "title": `${title} (${type})`,
        "status": "active",
        "description": statement,
        "purpose": description
    }
    if (refAlias && refAlias['$'].value != "" && refFunctionID && refFunctionID['$'].value != "") {
        fhir_headerOrFunction["derivedFrom"] = [ BASE_CANONICAL_PREFIX + refFunctionID['$'].value ];
    }
    if (refChangeInd) {
        fhir_headerOrFunction["extension"].push({
            "url": `${BASE_CANONICAL}/StructureDefinition/requirements-change-info`,
            "valueCode": refChangeInd['$'].value });
    }
    var resource = {
        "reference": { "reference": `Requirements/${FMID_PREFIX}-${alias}` },
        "isExample": false,
        "groupingId": alias.substring(0, alias.indexOf('.'))
    }
    resources.push(resource);

    return fhir_headerOrFunction;
}

function handleCriteria(criteria, fhir_parent_req) {
    const id = criteria.name[0];
    const name = criteria.name[0];
    var notes = criteria.notes[0];
    const optionality = criteria.tag.find(tag => tag['$'].name === 'Optionality');
    const conditional = criteria.tag.find(tag => tag['$'].name === 'Conditional');
    const dependent = criteria.tag.find(tag => tag['$'].name === 'Dependent');
    const refAlias = criteria.tag.find(tag => tag['$'].name === 'Reference.Alias');
    const refFunctionID = criteria.tag.find(tag => tag['$'].name === 'Reference.FunctionID');
    const refCriteriaID = criteria.tag.find(tag => tag['$'].name === 'Reference.CriterionID');
    const refChangeInd = criteria.tag.find(tag => tag['$'].name === 'Reference.ChangeIndicator');

    // replace special link notation '[[{id}]]' with markdown link
    notes = notes.replace(/\[\[([^\]]+)\]\]/g, `[\$1](Requirements-${FMID_PREFIX}-\$1.html)`);

    if (!fhir_parent_req) {
        console.log("parent not yet created? " + name);
        return;
    }
    var fhir_statement = {
        "extension": [
            {
                "url": `${BASE_CANONICAL}/StructureDefinition/requirements-dependent`,
                "valueBoolean": (dependent['$'].value=="Y")
            }
        ],
        "key": FMID_PREFIX + "-" + id.replace('#','-'),
        "label": name,
        "conformance": [
          optionality['$'].value
        ],
        "conditionality": (conditional['$'].value=="Y"),
        "requirement": notes
    };
    if (!fhir_parent_req.statement) { fhir_parent_req.statement = [] }
    if (refAlias && refAlias['$'].value != "" && refFunctionID && refFunctionID['$'].value != "") {
        fhir_statement["derivedFrom"] = refFunctionID['$'].value + (refCriteriaID?"#" + refCriteriaID['$'].value:"");
    }
    if (refChangeInd) {
        fhir_statement["extension"].push({
            "url": `${BASE_CANONICAL}/StructureDefinition/requirements-change-info`,
            "valueCode": refChangeInd['$'].value });
    }
    if (id in satisfiedBy) { fhir_statement["satisfiedBy"] = [ satisfiedBy[id]] }
    fhir_parent_req.statement.push(fhir_statement);
}

function sort(obj) {
    // sort by FM ID
    var section_sortkey = [];
    // EHR-S FM
    section_sortkey['OV'] = '1OV';
    section_sortkey['CP'] = '2CP';
    section_sortkey['CPS'] = '3CPS';
    section_sortkey['AS'] = '4AS';
    section_sortkey['POP'] = '5POP';
    section_sortkey['RI'] = '6RI';
    section_sortkey['TI'] = '7TI';
    // extra UFP chapter
    section_sortkey['U'] = '8U';    
    // extra PHR-S FM chapters
    section_sortkey['PH'] = '1PH';
    section_sortkey['S'] = '2S';

    obj['model'].objects[0].object.sort(function (a,b) {
        var aname = a.name;
        var bname = b.name;
        // Package should be first!
        if (a.stereotype == 'HL7-FM-ProfileDefinition' || a.stereotype == 'HL7-FM-Profile' || a.stereotype == 'HL7-FM') {
            aname = "0" + aname;
        }
        if (a.stereotype == 'HL7-FM-ProfileDefinition' || b.stereotype == 'HL7-FM-Profile' || a.stereotype == 'HL7-FM') {
            bname = "0" + bname;
        }

        if (a.stereotype == 'Section') {
            aname = section_sortkey[a.alias];
        }
        else if (a.stereotype == 'Header' || a.stereotype == 'Function') {
            var p = a.alias[0].split(/[\.]/);
            aname = section_sortkey[p[0]];
            for(var i=1; i<p.length; i++){
                aname += '.';
                var num = Number(p[i]);
                if (num<10) aname += '0';
                aname += num;
            }
        }
        else if (a.stereotype == 'Criteria') {
            var p = a.name[0].split(/[\.#]/);
            aname = section_sortkey[p[0]];
            for(var i=1; i<p.length-1; i++){
                aname += '.';
                var num = Number(p[i]);
                if (num<10) aname += '0';
                aname += num;
            }
            aname += '#';
            var cnum = Number(p[p.length-1]);
            if (cnum<10) aname += '00';
            else if (cnum<100) aname += '0';
            aname += cnum;
        }

        if (b.stereotype == 'Section') {
            bname = section_sortkey[b.alias];
        }
        else if (b.stereotype == 'Header' || b.stereotype == 'Function') {
            var p = b.alias[0].split(/[\.]/);
            bname = section_sortkey[p[0]];
            for(var i=1; i<p.length; i++){
                bname += '.';
                if (p[i]<10) bname += '0';
                bname += p[i];
            }
        }
        else if (b.stereotype == 'Criteria') {
            var p = b.name[0].split(/[\.#]/);
            bname = section_sortkey[p[0]];
            for(var i=1; i<p.length-1; i++){
                bname += '.';
                var num = Number(p[i]);
                if (num<10) bname += '0';
                bname += num;
            }
            bname += '#';
            var cnum = Number(p[p.length-1]);
            if (cnum<10) bname += '00';
            else if (cnum<100) bname += '0';
            bname += cnum;
        }
        // console.log(aname + " " + bname);
        return (aname > bname) ? 1 : -1 ;
    });    
}

function sortResources(obj) {
    // sort by FM ID
    var section_sortkey = [];
    // EHR-S FM and UFP chapters
    section_sortkey['OV'] = '1OV';
    section_sortkey['CP'] = '2CP';
    section_sortkey['CPS'] = '3CPS';
    section_sortkey['AS'] = '4AS';
    section_sortkey['POP'] = '5POP';
    section_sortkey['RI'] = '6RI';
    section_sortkey['TI'] = '7TI';
    // extra UFP chapter
    section_sortkey['U'] = '8U';    
    // extra PHR-S FM chapters
    section_sortkey['PH'] = '1PH';
    section_sortkey['S'] = '2S';

    resources.sort(function (a,b) {
        var aref = a.reference.reference;
        var bref = b.reference.reference;
        var aname = aref.substring(aref.indexOf('-')+1);
        var bname = bref.substring(bref.indexOf('-')+1);

        var p = aname.split(/[\.]/);
        aname = section_sortkey[p[0]];
        for(var i=1; i<p.length; i++){
            aname += '.';
            var num = Number(p[i]);
            if (num<10) aname += '0';
            aname += num;
        }

        var p = bname.split(/[\.]/);
        bname = section_sortkey[p[0]];
        for(var i=1; i<p.length; i++){
            bname += '.';
            if (p[i]<10) bname += '0';
            bname += p[i];
        }
        //console.log(aname + " " + bname);
        return (aname > bname) ? 1 : -1 ;
    });    
}