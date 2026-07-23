const XLSX = require('xlsx');
const fs = require('fs');
const xml2js = require('xml2js');

const inputFile = 'input/images/Patient Centric Med List Med Reconciliation-Use Case Analysis Worksheet-20260705.xlsx';
const outputFile = 'script/medlist-profiledefinition.max';
const baseFile = 'script/phrs-fm.max';

const workbook = XLSX.readFile(inputFile);
const sheetName = workbook.SheetNames[0];
const worksheet = workbook.Sheets[sheetName];
const data = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

// setup profile definition MAX object
const PID = "MEDLIST";
const obj = {
    'model': {
        $: { 'xmlns': 'http://www.umcg.nl/MAX' },
        objects: {
            $: { 'xmlns': '' },
            object: [{
                id: PID,
                name: PID,
                alias: "",
                stereotype: "HL7-FM-ProfileDefinition",
                type: "Package",
                tag: [{ $: { name: "PrioritiesDescription", value: "" } },
                { $: { name: "Type", value: "Domain" } },
                { $: { name: "Rationale", value: "<memo>" } },
                { $: { name: "Version", value: "1.0" } },
                { $: { name: "Scope", value: "<memo>" } },
                { $: { name: "LanguageTag", value: "" } },
                { $: { name: "PrioritiesDefinition", value: "<memo>" } },
                { $: { name: "ConformanceClause", value: "<memo>" } }
                ]
            }]
        },
        relationships: {
            $: { 'xmlns': '' },
            relationship: []
        }
    }
};

// read base model to get the IDs of the functions and criteria
const parser = new xml2js.Parser();
const basemax = fs.readFileSync(baseFile, 'utf8');
const fmidlookup = [];
const maxcriteria = []; // store max criteria ID per function for later use in assigning new criteria IDs
parser.parseString(basemax, function (err, result) {
    result['model'].objects[0].object.forEach(object => {
        switch (object.stereotype[0]) {
            case "Header":
            case "Function":
                fmidlookup[object.alias[0]] = object.id[0];
                break;
            case "Criteria":
                fmidlookup[object.name[0]] = object.id[0];
                const [functionId, criteriaId] = object.name[0].split('#');
                // assume base model is sorted by function and criteria, so the last criteria ID for each function is the highest
                maxcriteria[functionId] = parseInt(criteriaId, 10);
                break;
        }
    });
});

function convertCriteriaId(value) {
    if (typeof value !== 'string') return value;

    const trimmed = value.trim();
    const match = trimmed.match(/^(.*)\s*,\s*CC#\s*(\d+)$/i);
    if (!match) return trimmed;

    const prefix = match[1].trim();
    const number = parseInt(match[2], 10);
    return `${prefix}#${String(number).padStart(2, '0')}`;
}

const functions = [];
const rows = data.slice(6);
let rowno = 0;
rows.forEach(row => {
    rowno++;
    const EVENT_STEP = row[0]; // use as reference
    let CRITERIA_ID = convertCriteriaId(row[10]);
    const CRITERIA = row[11];

    // TODO: CHECK if this is a NEW criteria row
    if (CRITERIA_ID && CRITERIA) {
        let _optionality = '';
        if (CRITERIA.includes(" SHALL ")) _optionality = "SHALL";
        else if (CRITERIA.includes(" SHOULD ")) _optionality = "SHOULD";
        else if (CRITERIA.includes(" MAY ")) _optionality = "MAY";
        let _dependent = "N";
        if (CRITERIA.includes('according to scope of practice') ||
            CRITERIA.includes('organizational policy') ||
            CRITERIA.includes('jurisdictional law')) _dependent = "Y";
        let _stereotype = "CI";
        let _type = "Class";
        if (CRITERIA_ID.match(/ \[NEW\]$/)) {
            _stereotype = "Criteria";
            _type = "Requirement";
            const functionId = CRITERIA_ID.split(' ')[0].trim();
            if (!maxcriteria[functionId]) maxcriteria[functionId] = 0;
            const next = maxcriteria[functionId] + 1;
            maxcriteria[functionId] = next;
            CRITERIA_ID = CRITERIA_ID.replace(/\s*\[NEW\]$/i, '#'+String(next).padStart(2, '0'));
            // TODO: find the next available number for this FUNCTION_ID and replace #00 with that number
        }
        const FUNCTION_ID = CRITERIA_ID.split('#')[0].trim();

        // check if function object exists, if not create it and associated relationship
        if (!functions.includes(FUNCTION_ID)) {
            functions.push(FUNCTION_ID);
            obj['model'].objects.object.push({
                id: PID+FUNCTION_ID,
                name: FUNCTION_ID, // BUG: required for R2ProfileCompiler.cs
                alias: FUNCTION_ID,
                stereotype: "CI",
                type: "Class",
                parentId: PID,
                tag: [{ $: { name: "Reference.ChangeInfo", value: "NC" } }] // BUG: required for R2ProfileCompiler.cs
            });
            functions.push(FUNCTION_ID);

            obj['model'].relationships.relationship.push({
                type: "Generalization",
                sourceId: PID+FUNCTION_ID,
                destId: fmidlookup[FUNCTION_ID] // lookup in base model
            });
        }

        // create criteria object and add to MAX object
        obj['model'].objects.object.push({
            id: PID+CRITERIA_ID,
            name: CRITERIA_ID,
            notes: CRITERIA,
            stereotype: _stereotype,
            type: _type,
            parentId: PID,
            tag: [{ $: { name: "Row", value: rowno } },
            { $: { name: "Optionality", value: _optionality } },
            { $: { name: "Conditional", value: CRITERIA.startsWith("IF ") ? "Y" : "N" } },
            { $: { name: "Dependent", value: _dependent } },
            // { $: { name: "Reference.ChangeInfo", value: "N" } } // derived from compile
            ]
        });
        if (_stereotype === "Criteria") {
            obj['model'].relationships.relationship.push({
                type: "Aggregation",
                sourceId: PID+CRITERIA_ID,
                destId: fmidlookup[FUNCTION_ID] // lookup in base model
            });
        } else if (_stereotype === "CI") {
            obj['model'].relationships.relationship.push({
                type: "Generalization",
                sourceId: PID+CRITERIA_ID,
                destId: fmidlookup[CRITERIA_ID] // lookup in base model
            });
        }
    }
});

const builder = new xml2js.Builder({ headless: true, renderOpts: { pretty: true } });
const xml = builder.buildObject(obj);

fs.writeFileSync(outputFile, xml);
console.log(`Converted Excel to MAX XML and saved to ${outputFile}`);