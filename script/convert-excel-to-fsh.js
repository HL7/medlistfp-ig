const XLSX = require('xlsx');
const fs = require('fs');

const inputFile = 'script/Patient Centric Med List Med Reconciliation-Use Case Analysis Worksheet-20260423.xlsx';
const outputFile = 'input/fsh/ExampleScenario.fsh';

const workbook = XLSX.readFile(inputFile);
const sheetName = workbook.SheetNames[0];
const worksheet = workbook.Sheets[sheetName];
const data = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

const rows = data.slice(6);

let fshContent = '';
let currentScenario = null;

rows.forEach(row => {
    if (row[0] && row[0].toString().includes('Med List/Med Rec Scenario')) {
        if (currentScenario) {
            fshContent += generateScenarioFsh(currentScenario);
        }
        currentScenario = {
            title: row[0],
            description: '',
            actors: new Map(),
            steps: [],
            instances: []
        };
    } else if (currentScenario && !currentScenario.description && row[0] && !row[1]) {
        currentScenario.description = row[0];
    } else if (currentScenario && row[0] && /^[0-9]+[A-Z]$/.test(row[0])) {
        const actorTitle = row[1];
        let actorId = '';
        if (actorTitle && !currentScenario.actors.has(actorTitle)) {
            actorId = actorTitle.toLowerCase().replace(/[^a-z0-9]/g, '-');
            const type = actorTitle.includes('System') ? '#system' : '#person';
            currentScenario.actors.set(actorTitle, { id: actorId, type });
        } else if (actorTitle) {
            actorId = currentScenario.actors.get(actorTitle).id;
        }

        const instanceKeys = { response: null, request: null };
        
        // Column E (index 4) -> Response
        if (row[4]) {
            const key = `inst-${currentScenario.steps.length}-resp`;
            currentScenario.instances.push({ key: key, description: row[4], stepNumber: row[0], type: 'resp' });
            instanceKeys.response = key;
        }
        // Column F (index 5) -> Request
        if (row[5]) {
            const key = `inst-${currentScenario.steps.length}-req`;
            currentScenario.instances.push({ key: key, description: row[5], stepNumber: row[0], type: 'req' });
            instanceKeys.request = key;
        }

        if (row[3]) {
            const steps = row[3].toString().split('\n').map(s => s.trim()).filter(s => s.length > 0);
            steps.forEach(step => {
                let number = row[0];
                let title = step;
                
                const match = title.match(/^([0-9]+[\.\)])\s*(.*)/);
                if (match) {
                    number += match[1].replace(/[\.\)]/, '');
                    title = match[2];
                }
                
                currentScenario.steps.push({
                    number: number,
                    title: title,
                    initiator: actorId,
                    instanceKeys: instanceKeys
                });
            });
        }
    }
});

if (currentScenario) {
    fshContent += generateScenarioFsh(currentScenario);
}

function generateScenarioFsh(scenario) {
    const id = scenario.title.split(' - ')[0].replace(/[^a-zA-Z0-9]/g, '-').toLowerCase();
    let content = `Instance: ${id}
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "${scenario.title.replace(/"/g, '\\"')}"
* description = "${scenario.description.replace(/"/g, '\\"')}"
`;

    scenario.instances.forEach((inst, index) => {
        const lines = inst.description.toString().split('\n');
        const title = `${lines[0].trim()} - ${inst.stepNumber} (${inst.type})`;
        const description = lines.slice(1).join('\n').trim().replace(/^FHIR Resources:[\s,]*/, '');
        
        content += `* instance[${index}].key = "${inst.key}"
* instance[${index}].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[${index}].title = "${title.replace(/"/g, '\\"')}"
* instance[${index}].description = "${description.replace(/"/g, '\\"').replace(/\n/g, ', ')}"
`;
    });

    let actorIndex = 0;
    scenario.actors.forEach((actor, title) => {
        content += `* actor[${actorIndex}].key = "${actor.id}"
* actor[${actorIndex}].type = ${actor.type}
* actor[${actorIndex}].title = "${title}"
`;
        actorIndex++;
    });

    content += `* process.title = "Main Process"
`;

    scenario.steps.forEach((step, index) => {
        content += `* process[0].step[${index}].number = "${step.number}"
* process[0].step[${index}].operation.title = "${step.title.replace(/"/g, '\\"')}"
* process[0].step[${index}].operation.initiator = "${step.initiator}"
`;
        if (step.instanceKeys.response) {
            content += `* process[0].step[${index}].operation.response.instanceReference = "${step.instanceKeys.response}"
`;
        }
        if (step.instanceKeys.request) {
            content += `* process[0].step[${index}].operation.request.instanceReference = "${step.instanceKeys.request}"
`;
        }
    });
    
    content += '\n';
    return content;
}

fs.writeFileSync(outputFile, fshContent);
console.log(`FSH generated successfully in ${outputFile}`);