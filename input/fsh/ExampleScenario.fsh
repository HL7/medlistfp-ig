Instance: med-list-med-rec-scenario-1-1
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.1 -  Notification to Confirm Appointment"
* description = "Ms. Jones, a 58-year-old mother of two, has an appointment to see her primary care provider (PCP) for a scheduled office follow-up visit. Her medical problems include hypertension, diabetes, and obesity. Because of uncontrolled hypertension she has been seen in the past week by a cardiologist. She receives an automatically generated email and text asking her to confirm the appointment and to complete pre-visit information.  One of the tasks she is asked to complete is to provide an up-to-date list of the medications she is currently taking."
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "Patient Registration Record - 1A (resp)"
* instance[0].description = "US Core - Patient, US Core - Practitioner, US Core - Condition Problems and Health Concerns, US Core - Encounter(planned), Standardized Medication Profile - MedicationList"
* instance[1].key = "inst-0-req"
* instance[1].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[1].title = "Communication Record - 1A (req)"
* instance[1].description = "US Core - Provenance, US Core - Encounter(planned), US Core - Practitioner, Standardized Medication Profile - MedicationStatement"
* instance[2].key = "inst-2-resp"
* instance[2].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[2].title = "Communication Record - 1B (resp)"
* instance[2].description = "Base FHIR Communication"
* instance[3].key = "inst-2-req"
* instance[3].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[3].title = "Communication Record - 1B (req)"
* instance[3].description = "Base FHIR CommunicationRequest, US Core - Provenance"
* instance[4].key = "inst-3-resp"
* instance[4].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[4].title = "Communication Record - 1C (resp)"
* instance[4].description = "Base FHIR CommunicationRequest, US Core - Provenance"
* instance[5].key = "inst-3-req"
* instance[5].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[5].title = "1) Appointment Notification - 1C (req)"
* instance[5].description = "2) Medication List Review Notification, , FHIR Resources:, Base FHIR Communication"
* actor[0].key = "ehr-system"
* actor[0].type = #system
* actor[0].title = "EHR System"
* process.title = "Main Process"
* process[0].step[0].number = "1A1"
* process[0].step[0].operation.title = "Notify Patient to confirm upcoming appointment"
* process[0].step[0].operation.initiator = "ehr-system"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"
* process[0].step[0].operation.request.instanceReference = "inst-0-req"
* process[0].step[1].number = "1A2"
* process[0].step[1].operation.title = "Notify Patient to provide up-to-date list of medications taken"
* process[0].step[1].operation.initiator = "ehr-system"
* process[0].step[1].operation.response.instanceReference = "inst-0-resp"
* process[0].step[1].operation.request.instanceReference = "inst-0-req"
* process[0].step[2].number = "1B"
* process[0].step[2].operation.title = "Retain Communication Record"
* process[0].step[2].operation.initiator = "ehr-system"
* process[0].step[2].operation.response.instanceReference = "inst-2-resp"
* process[0].step[2].operation.request.instanceReference = "inst-2-req"
* process[0].step[3].number = "1C"
* process[0].step[3].operation.title = "Transmit Notifications"
* process[0].step[3].operation.initiator = "ehr-system"
* process[0].step[3].operation.response.instanceReference = "inst-3-resp"
* process[0].step[3].operation.request.instanceReference = "inst-3-req"

Instance: med-list-med-rec-scenario-1-2
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.2 -  Confirm Appointment"
* description = "Ms. Jones clicks on the hyperlink in the email, opening the patient portal of the EHR of the PCP practice. She logs into the patient portal. [Alternatively, a patient surrogate / patient agent could be performing this.] She completes the administrative tasks in preparation for the visit. Integrated into the workflow is a dedicated page prompting her to review and update her medications list. The EHR presents a list of health information systems relevant to her medications management."
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "Account Holder Access Credentials - 1A (resp)"
* instance[0].description = "US Core - Patient, US Core - RelatedPerson, US Core - Condition, US Core - Encounter(Planned), Standardized Medication Profile - MedicationList"
* instance[1].key = "inst-0-req"
* instance[1].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[1].title = "Account Holder Access Record - 1A (req)"
* instance[1].description = "US Core - Provenance"
* instance[2].key = "inst-2-resp"
* instance[2].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[2].title = "Account Holder Access Record - 1B (resp)"
* instance[2].description = "US Core - Provenance"
* instance[3].key = "inst-2-req"
* instance[3].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[3].title = "Account Holder Access Record - 1B (req)"
* instance[3].description = "US Core - Provenance"
* instance[4].key = "inst-3-resp"
* instance[4].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[4].title = "Appointment Record - 2A (resp)"
* instance[4].description = "US Core - Patient, US Core - RelatedPerson, US Core - Practitioner, US Core - Organization, US Core - Location, US Core - Encounter(Planned)"
* instance[5].key = "inst-3-req"
* instance[5].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[5].title = "Appointment Record - 2A (req)"
* instance[5].description = "US Core - Practitioner, US Core - Organization, US Core - Location, US Core - Encounter(Planned)"
* instance[6].key = "inst-4-resp"
* instance[6].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[6].title = "Appointment Record - 2B (resp)"
* instance[6].description = "US Core - Practitioner, US Core - Organization, US Core - Location, US Core - Encounter(Planned)"
* instance[7].key = "inst-4-req"
* instance[7].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[7].title = "Appointment Record - 2B (req)"
* instance[7].description = "US Core - Provenance"
* instance[8].key = "inst-5-resp"
* instance[8].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[8].title = "Patient Demographic Record - 3A (resp)"
* instance[8].description = "US Core - Patient, US Core - RelatedPerson, US Core - Interpreter Needed, US Core - Observation Occupation"
* instance[9].key = "inst-5-req"
* instance[9].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[9].title = "Updated Patient Demographic Record - 3A (req)"
* instance[9].description = "US Core - Patient, US Core - Interpreter Needed, US Core - Observation Occupation"
* instance[10].key = "inst-6-resp"
* instance[10].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[10].title = "Updated Patient Demographic Record - 3B (resp)"
* instance[10].description = "US Core - Patient, US Core - Interpreter Needed, US Core - Observation Occupation"
* instance[11].key = "inst-6-req"
* instance[11].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[11].title = "Updated Patient Demographic Record - 3B (req)"
* instance[11].description = "US Core - Provenance"
* instance[12].key = "inst-7-resp"
* instance[12].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[12].title = "Patient Insurance Coverage Record - 4A (resp)"
* instance[12].description = "US Core - Coverage, US Core - Organization, US Core - Location"
* instance[13].key = "inst-7-req"
* instance[13].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[13].title = "Updated Patient Insurance Coverage Record - 4A (req)"
* instance[13].description = "US Core - Coverage, US Core - Organization, US Core - Location"
* instance[14].key = "inst-8-resp"
* instance[14].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[14].title = "Updated Patient Insurance Coverage Record - 4B (resp)"
* instance[14].description = "US Core - Coverage, US Core - Organization, US Core - Location"
* instance[15].key = "inst-8-req"
* instance[15].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[15].title = "Updated Patient Insurance Coverage Record - 4B (req)"
* instance[15].description = "US Core - Provenance"
* instance[16].key = "inst-9-resp"
* instance[16].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[16].title = "Patient Allergy List - 5A (resp)"
* instance[16].description = "US Core - Patient, US Core - RelatedPerson, US Core - AllergyIntolerance"
* instance[17].key = "inst-9-req"
* instance[17].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[17].title = "Patient Allergy List - 5A (req)"
* instance[17].description = "US Core - AllergyIntolerence"
* instance[18].key = "inst-10-resp"
* instance[18].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[18].title = "Updated Patient Allergy List - 5B (resp)"
* instance[18].description = "US Core - Patient, US Core - RelatedPerson, US Core - AllergyIntolerence"
* instance[19].key = "inst-10-req"
* instance[19].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[19].title = "Updated Patient Allergy List - 5B (req)"
* instance[19].description = "US Core - Provenance"
* instance[20].key = "inst-11-resp"
* instance[20].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[20].title = "Patient Travel Record - 6A (resp)"
* instance[20].description = "US Core - Patient, US Core - RelatedPerson, US Core - SimpleObservation(Not a good way to record and update travel history in USCDI)"
* instance[21].key = "inst-11-req"
* instance[21].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[21].title = "Updated Patient Travel Record - 6A (req)"
* instance[21].description = "US Core - Patient, US Core - SimpleObservation"
* instance[22].key = "inst-12-resp"
* instance[22].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[22].title = "Updated Patient Travel Record - 6B (resp)"
* instance[22].description = "US Core - Patient, US Core - SimpleObservation"
* instance[23].key = "inst-12-req"
* instance[23].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[23].title = "Updated Patient Travel Record - 6B (req)"
* instance[23].description = "US Core - Provenance"
* instance[24].key = "inst-13-resp"
* instance[24].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[24].title = "Patient Consents and Authorizations - 7A (resp)"
* instance[24].description = "US Core - Patient, US Core - RelatedPerson, Base FHIR Consent"
* instance[25].key = "inst-13-req"
* instance[25].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[25].title = "Updated Patient Consents and Authorizations - 7A (req)"
* instance[25].description = "US Core - Patient, Base FHIR Consent"
* instance[26].key = "inst-14-resp"
* instance[26].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[26].title = "Updated Patient Consents and Authorizations - 7B (resp)"
* instance[26].description = "Base FHIR Consent"
* instance[27].key = "inst-14-req"
* instance[27].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[27].title = "Updated Patient Consents and Authorizations - 7B (req)"
* instance[27].description = "US Core - Provenance"
* instance[28].key = "inst-15-resp"
* instance[28].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[28].title = "Patient Pre-Appointment Information Requests - 8A (resp)"
* instance[28].description = "US Core - Patient, US Core - RelatedPerson, Base FHIR Questionnaire"
* instance[29].key = "inst-15-req"
* instance[29].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[29].title = "Updated Patient Pre-Appointment Information Requests - 8A (req)"
* instance[29].description = "US Core - Patient, US Core - QuestionnaireResponse"
* instance[30].key = "inst-16-resp"
* instance[30].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[30].title = "Updated Patient Pre-Appointment Questionnaire - 8B (resp)"
* instance[30].description = "US Core - QuestionnaireResponse"
* instance[31].key = "inst-16-req"
* instance[31].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[31].title = "Updated Patient Pre-Appointment Information Requests - 8B (req)"
* instance[31].description = "Provenance"
* instance[32].key = "inst-17-resp"
* instance[32].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[32].title = "Notice(s) - 9A (resp)"
* instance[32].description = "US Core - Patient, US Core - RelatedPerson, Base FHIR Consent"
* instance[33].key = "inst-17-req"
* instance[33].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[33].title = "Acknowledged/Signed Receipt of Notice(s) - 9A (req)"
* instance[33].description = "US Core - Patient, Base FHIR Consent"
* instance[34].key = "inst-18-resp"
* instance[34].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[34].title = "Acknowledged/Signed Receipt of Notice(s) - 9B (resp)"
* instance[34].description = "US Core - Patient, Base FHIR Consent"
* instance[35].key = "inst-18-req"
* instance[35].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[35].title = "Acknowledged/Signed Receipt of Notice(s) - 9B (req)"
* instance[35].description = "US Core - Provenance"
* actor[0].key = "patient--or-surrogate-"
* actor[0].type = #person
* actor[0].title = "Patient (or Surrogate)"
* actor[1].key = "ehr-system"
* actor[1].type = #system
* actor[1].title = "EHR System"
* process.title = "Main Process"
* process[0].step[0].number = "1A"
* process[0].step[0].operation.title = "Access Portal Account"
* process[0].step[0].operation.initiator = "patient--or-surrogate-"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"
* process[0].step[0].operation.request.instanceReference = "inst-0-req"
* process[0].step[1].number = "1A"
* process[0].step[1].operation.title = "(Portal to Provider EHR System)"
* process[0].step[1].operation.initiator = "patient--or-surrogate-"
* process[0].step[1].operation.response.instanceReference = "inst-0-resp"
* process[0].step[1].operation.request.instanceReference = "inst-0-req"
* process[0].step[2].number = "1B"
* process[0].step[2].operation.title = "Retain Account Holder Access Record"
* process[0].step[2].operation.initiator = "ehr-system"
* process[0].step[2].operation.response.instanceReference = "inst-2-resp"
* process[0].step[2].operation.request.instanceReference = "inst-2-req"
* process[0].step[3].number = "2A"
* process[0].step[3].operation.title = "Review/update/confirm appointment"
* process[0].step[3].operation.initiator = "patient--or-surrogate-"
* process[0].step[3].operation.response.instanceReference = "inst-3-resp"
* process[0].step[3].operation.request.instanceReference = "inst-3-req"
* process[0].step[4].number = "2B"
* process[0].step[4].operation.title = "Retain Appointment Record"
* process[0].step[4].operation.initiator = "ehr-system"
* process[0].step[4].operation.response.instanceReference = "inst-4-resp"
* process[0].step[4].operation.request.instanceReference = "inst-4-req"
* process[0].step[5].number = "3A"
* process[0].step[5].operation.title = "Review/update patient demographics"
* process[0].step[5].operation.initiator = "patient--or-surrogate-"
* process[0].step[5].operation.response.instanceReference = "inst-5-resp"
* process[0].step[5].operation.request.instanceReference = "inst-5-req"
* process[0].step[6].number = "3B"
* process[0].step[6].operation.title = "Retain Patient Demographic Record"
* process[0].step[6].operation.initiator = "ehr-system"
* process[0].step[6].operation.response.instanceReference = "inst-6-resp"
* process[0].step[6].operation.request.instanceReference = "inst-6-req"
* process[0].step[7].number = "4A"
* process[0].step[7].operation.title = "Review/update patient insurance coverage and co-pays"
* process[0].step[7].operation.initiator = "patient--or-surrogate-"
* process[0].step[7].operation.response.instanceReference = "inst-7-resp"
* process[0].step[7].operation.request.instanceReference = "inst-7-req"
* process[0].step[8].number = "4B"
* process[0].step[8].operation.title = "Retain Patient Insurance Coverage Record"
* process[0].step[8].operation.initiator = "ehr-system"
* process[0].step[8].operation.response.instanceReference = "inst-8-resp"
* process[0].step[8].operation.request.instanceReference = "inst-8-req"
* process[0].step[9].number = "5A"
* process[0].step[9].operation.title = "Review/update patient allergy list"
* process[0].step[9].operation.initiator = "patient--or-surrogate-"
* process[0].step[9].operation.response.instanceReference = "inst-9-resp"
* process[0].step[9].operation.request.instanceReference = "inst-9-req"
* process[0].step[10].number = "5B"
* process[0].step[10].operation.title = "Retain Patient Allergy Record"
* process[0].step[10].operation.initiator = "ehr-system"
* process[0].step[10].operation.response.instanceReference = "inst-10-resp"
* process[0].step[10].operation.request.instanceReference = "inst-10-req"
* process[0].step[11].number = "6A"
* process[0].step[11].operation.title = "Review/update patient travel information"
* process[0].step[11].operation.initiator = "patient--or-surrogate-"
* process[0].step[11].operation.response.instanceReference = "inst-11-resp"
* process[0].step[11].operation.request.instanceReference = "inst-11-req"
* process[0].step[12].number = "6B"
* process[0].step[12].operation.title = "Retain Patient Travel Record"
* process[0].step[12].operation.initiator = "ehr-system"
* process[0].step[12].operation.response.instanceReference = "inst-12-resp"
* process[0].step[12].operation.request.instanceReference = "inst-12-req"
* process[0].step[13].number = "7A"
* process[0].step[13].operation.title = "Review/update consents and authorizations"
* process[0].step[13].operation.initiator = "patient--or-surrogate-"
* process[0].step[13].operation.response.instanceReference = "inst-13-resp"
* process[0].step[13].operation.request.instanceReference = "inst-13-req"
* process[0].step[14].number = "7B"
* process[0].step[14].operation.title = "Retain Patient Consents and Authorizations Record"
* process[0].step[14].operation.initiator = "ehr-system"
* process[0].step[14].operation.response.instanceReference = "inst-14-resp"
* process[0].step[14].operation.request.instanceReference = "inst-14-req"
* process[0].step[15].number = "8A"
* process[0].step[15].operation.title = "Review/update pre-appointment information requests"
* process[0].step[15].operation.initiator = "patient--or-surrogate-"
* process[0].step[15].operation.response.instanceReference = "inst-15-resp"
* process[0].step[15].operation.request.instanceReference = "inst-15-req"
* process[0].step[16].number = "8B"
* process[0].step[16].operation.title = "Retain Patient Pre-Appointment Information Requests"
* process[0].step[16].operation.initiator = "ehr-system"
* process[0].step[16].operation.response.instanceReference = "inst-16-resp"
* process[0].step[16].operation.request.instanceReference = "inst-16-req"
* process[0].step[17].number = "9A"
* process[0].step[17].operation.title = "Acknowledge/sign receipt for notices (e.g., HIPAA notices, notices of privacy or information practices)"
* process[0].step[17].operation.initiator = "patient--or-surrogate-"
* process[0].step[17].operation.response.instanceReference = "inst-17-resp"
* process[0].step[17].operation.request.instanceReference = "inst-17-req"
* process[0].step[18].number = "9B"
* process[0].step[18].operation.title = "Retain Patient Acknowledgement/ Signature confirming Receipt of Notice(s)"
* process[0].step[18].operation.initiator = "ehr-system"
* process[0].step[18].operation.response.instanceReference = "inst-18-resp"
* process[0].step[18].operation.request.instanceReference = "inst-18-req"

Instance: med-list-med-rec-scenario-1-3
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.3 -  Query External Systems"
* description = "The portal shows [Ms.Jones] the active medication list as maintained by the EHR, displayed in a high usability format with patient friendly text. Integrated into the workflow, the app executes a call for medication list data from other systems with her medication list information since the last medication reconciliation event."
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "Active Patient Medication List Query - 1A (resp)"
* instance[0].description = "US Core - Patient , US Core - Organization, US Core - Practitioner, US Core - Provenance (of last medication reconcilliation event)"
* instance[1].key = "inst-0-req"
* instance[1].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[1].title = "Active Patient Medication List Query - 1A (req)"
* instance[1].description = "Standardized Medication Profile - Parameters - Query"
* instance[2].key = "inst-1-resp"
* instance[2].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[2].title = "Active Patient Medication List Query - 1B (resp)"
* instance[2].description = "Standardized Medication Profile - Parameters - Query"
* instance[3].key = "inst-1-req"
* instance[3].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[3].title = "Active Patient Medication List Query - 1B (req)"
* instance[3].description = "Standardized Medication Profile - Parameters - Query"
* instance[4].key = "inst-2-resp"
* instance[4].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[4].title = "Active Patient Medication List Query - 1C (resp)"
* instance[4].description = "Standardized Medication Profile - Parameters - Query"
* instance[5].key = "inst-2-req"
* instance[5].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[5].title = "Active Patient Medication List Query - 1C (req)"
* instance[5].description = "US Core - Provenance"
* instance[6].key = "inst-3-req"
* instance[6].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[6].title = "Active Patient Medication List Query Response - 2A (req)"
* instance[6].description = "Standardized Medication Profile - Parameters - Response, Standardized Medication Profile - Parameters - Outcome, Standardized Medication Profile - Medication List (as maintained by System), Standardized Medication Profile - MedicationStatement (as reported by Patient)"
* instance[7].key = "inst-4-resp"
* instance[7].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[7].title = "Active Patient Medication List Query Response - 2B (resp)"
* instance[7].description = "Standardized Medication Profile - Parameters - Response, Standardized Medication Profile - Parameters - Outcome"
* instance[8].key = "inst-4-req"
* instance[8].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[8].title = "Active Patient Medication List Query Response - 2B (req)"
* instance[8].description = "US Core - Provenance"
* actor[0].key = "ehr-system"
* actor[0].type = #system
* actor[0].title = "EHR System"
* process.title = "Main Process"
* process[0].step[0].number = "1A"
* process[0].step[0].operation.title = "Create query for Active List of Patient Medications"
* process[0].step[0].operation.initiator = "ehr-system"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"
* process[0].step[0].operation.request.instanceReference = "inst-0-req"
* process[0].step[1].number = "1B"
* process[0].step[1].operation.title = "Transmit Query to External Systems"
* process[0].step[1].operation.initiator = "ehr-system"
* process[0].step[1].operation.response.instanceReference = "inst-1-resp"
* process[0].step[1].operation.request.instanceReference = "inst-1-req"
* process[0].step[2].number = "1C"
* process[0].step[2].operation.title = "Retain Active Patient Medication List Query"
* process[0].step[2].operation.initiator = "ehr-system"
* process[0].step[2].operation.response.instanceReference = "inst-2-resp"
* process[0].step[2].operation.request.instanceReference = "inst-2-req"
* process[0].step[3].number = "2A"
* process[0].step[3].operation.title = "Receive Query Response from External Systems"
* process[0].step[3].operation.initiator = "ehr-system"
* process[0].step[3].operation.request.instanceReference = "inst-3-req"
* process[0].step[4].number = "2B"
* process[0].step[4].operation.title = "Retain Active Patient Medication List Query Response"
* process[0].step[4].operation.initiator = "ehr-system"
* process[0].step[4].operation.response.instanceReference = "inst-4-resp"
* process[0].step[4].operation.request.instanceReference = "inst-4-req"

Instance: med-list-med-rec-scenario-1-4
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.4 -  Review Medication List"
* description = "The EHR disambiguates the information and presents the following list to Ms. Jones:
•	Candesartan (Atacand) 8 mg every AM
•	Hydrochlorothiazide 12.5 mg every AM
•	Metformin SR (Glucophage XR) 500 mg every AM
•	Tirzepatide (Mounjaro) 5 mg subq every week
•	Sulfamethoxazole / trimethoprim (Bactrim, Septra) 800 / 160 mg twice a day"
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "<Any/All Prior Records> - 1A (resp)"
* instance[0].description = "Current Medication List, Current Medication Orders, Current Medication Dispensing Records, , FHIR Resources:, US Core - Patient, US Core - RelatedPerson, Standardized Medication Profile - Medication, Standardized Medication Profile - MedicationStatement, Standardized Medication Profile - MedicationList, Standardized Medication Profile - MedicationAdministration"
* instance[1].key = "inst-0-req"
* instance[1].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[1].title = "Updated Medication List - 1A (req)"
* instance[1].description = "Standardized Medication Profile - MedicationStatement, Standardized Medication Profile - Parameters - Submit"
* instance[2].key = "inst-1-resp"
* instance[2].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[2].title = "Updated Medication List - 1B (resp)"
* instance[2].description = "Standardized Medication Profile - Medication Statement"
* instance[3].key = "inst-1-req"
* instance[3].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[3].title = "Updated Medication List - 1B (req)"
* instance[3].description = "US Core - Provenance"
* actor[0].key = "patient-or-surrogate"
* actor[0].type = #person
* actor[0].title = "Patient or Surrogate"
* actor[1].key = "ehr-system"
* actor[1].type = #system
* actor[1].title = "EHR System"
* process.title = "Main Process"
* process[0].step[0].number = "1A"
* process[0].step[0].operation.title = "Review, Update and Confirm Medication List"
* process[0].step[0].operation.initiator = "patient-or-surrogate"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"
* process[0].step[0].operation.request.instanceReference = "inst-0-req"
* process[0].step[1].number = "1B"
* process[0].step[1].operation.title = "Retain Updated Medication List"
* process[0].step[1].operation.initiator = "ehr-system"
* process[0].step[1].operation.response.instanceReference = "inst-1-resp"
* process[0].step[1].operation.request.instanceReference = "inst-1-req"

Instance: med-list-med-rec-scenario-1-5
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.5 -  Output Medication List"
* description = "Ms. Jones prints a copy of her medication list for her personal use and to take with her visit to the PCP. "
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "Updated Medication List - 1A (resp)"
* instance[0].description = "Standardized Medication Profile - MedicationStatement"
* instance[1].key = "inst-0-req"
* instance[1].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[1].title = "Updated Medication List - 1A (req)"
* instance[1].description = "Standardized Medication Profile - MedicationStatement"
* actor[0].key = "patient-or-surrogate"
* actor[0].type = #person
* actor[0].title = "Patient or Surrogate"
* process.title = "Main Process"
* process[0].step[0].number = "1A"
* process[0].step[0].operation.title = "Output (Print) Updated Medication List"
* process[0].step[0].operation.initiator = "patient-or-surrogate"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"
* process[0].step[0].operation.request.instanceReference = "inst-0-req"

Instance: med-list-med-rec-scenario-1-6
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.6 -  Transmit Medication List"
* description = "[User story snippet goes here]"
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "Updated Medication List - 1A (resp)"
* instance[0].description = ""
* instance[1].key = "inst-0-req"
* instance[1].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[1].title = "Updated Medication List - 1A (req)"
* instance[1].description = ""
* actor[0].key = "ehr-system"
* actor[0].type = #system
* actor[0].title = "EHR System"
* process.title = "Main Process"
* process[0].step[0].number = "1A"
* process[0].step[0].operation.title = "Transmit Updated Medication List"
* process[0].step[0].operation.initiator = "ehr-system"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"
* process[0].step[0].operation.request.instanceReference = "inst-0-req"

Instance: med-list-med-rec-scenario-1-7-1
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.7.1 - Review/Print Med List - Alternate 1"
* description = "Ms. Jones opens the patient portal to update and print her medication list for her personal use"
* instance[0].key = "inst-0-resp"
* instance[0].structureType = http://hl7.org/fhir/fhir-types#Bundle
* instance[0].title = "Medication List - 1A (resp)"
* instance[0].description = ""
* actor[0].key = "patient"
* actor[0].type = #person
* actor[0].title = "Patient"
* process.title = "Main Process"
* process[0].step[0].number = "1A"
* process[0].step[0].operation.title = "Access/Print Medication List"
* process[0].step[0].operation.initiator = "patient"
* process[0].step[0].operation.response.instanceReference = "inst-0-resp"

Instance: med-list-med-rec-scenario-1-7-2
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.7.2 - Review/Print Med List - Alternate 2"
* description = "Ms. Jones opens the patient portal to update and print her medication list to take to a visit with a non-PCP clinician or dentist"
* process.title = "Main Process"

Instance: med-list-med-rec-scenario-1-7-3
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.7.3 - Review/Print Med List - Alternate 3"
* description = "Pharmacy new prescription fill triggers a prompt for Ms. Jones to update her medication list"
* process.title = "Main Process"

Instance: med-list-med-rec-scenario-1-7-4
InstanceOf: ExampleScenario
Usage: #example
* status = #draft
* title = "Med List/Med Rec Scenario 1.7.4 - Review/Print Med List - Alternate 4"
* description = "Clinician requests her to update her medication list to provide to the clinician to review"
* process.title = "Main Process"

