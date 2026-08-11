### Note to Readers: Introduction

1. The Package includes the following parts:
    * Overview (this and the following)
    * **HL7 PHR-S FM R2.0.1 - Patient-Centric Medication List Functional Profile (PCML FP) Edition 1** - an extension of ISO/HL7 16527 Personal Health Record System Functional Model R2.0.1 - as an informative document. (Functions and conformance criteria are ordered according to PHRS-FM sections and subsections.)
    * PCML FP [Use Case Analysis Worksheet](Patient Centric Med List Med Reconciliation-Use Case Analysis Worksheet-20260705.xlsx), including:
        1. User Story narrative;
        2. Analysis details:  event by event sequence (event steps), actors, actor roles, event descriptions, with corresponding data and functional requirements;
        3. Mapped to PHR-S FM functions and conformance criteria, extended as necessary;
        4. As developed by the Project Team.
    * Reference worksheet (final version of the worksheet used in team meetings to describe process steps and corresponding proposed conformance criteria)
2. The Patient-Centric Medication List (PCML) Project Team conducted an in-depth analysis of ISO/HL7 10781 EHR-S FM R2.1 and ISO/HL7 16527 PHR-S FM R2.0 to identify functions and criteria relevant to a patient-facing, patient-centric medication list management system. This is the first edition (release) of the FP. 

### Acknowledgements

This project was sponsored by the Health Level Seven International, Incorporated (HL7), and the University of Nebraska Medical Center – Center for Intelligent Healthcare (UNMC-CIHC). A Project Team focused on this Patient-Centric Medication List Functional Profile (PCML FP) was formed under the HL7 Electronic Health Record Work Group (EHR WG) – Reducing Clinical Burden (RCB) Project. The PCML FP expresses the concepts, functionality, and conformance criteria described in the manuscript, **Framework for Improving Patient Safety: Reference Model for FHIR-Enabled, Patient-Centric Home Medication List Management and Medication Reconciliation** (Bastola ND, Tcheng JE, Schlossman DM, Windle JR. Appl Clin Inform. 2025 Aug;16(4):1136-1145. doi: 10.1055/a-2599-4135). A prototype that illustrates and demonstrates the functionality expressed in the PCML FP is available on GitHub. Many thanks to all who participated in project team meetings and contributed to the analysis and development of the PCML FP. 

### Background

#### Project Scope Statement

The scope of this project [PSS-2571](https://jira.hl7.org/browse/PSS-2571)
 is to develop a PHR System Patient-Centric Medication List Functional Profile Release 2.0.1, referred hereinafter as PCML FP, by identifying functions and conformance criteria from HL7 Electronic Health Record System Functional Model (EHR-S FM), Release 2.1.1 and the HL7 Personal Health Record System Functional Model (PHR-S FM), Release 2.0.1, then modifying and adding to those functions and conformance criteria where appropriate.

The Project uses the Common HL7 Toolset (FHIR Implementation Guide Publisher) to develop, ballot, and publish the PCML FP. 

#### Profile for US Realm

The PCML FP is targeted to the US Realm. However, the profile can be adopted globally as the content has no geographical limitations.

#### Sponsors

**HL7 International and HL7 EHR Work Group**

Founded in 1987, Health Level Seven International (HL7, www.HL7.org) is a not-for-profit healthcare standards development organization (SDO) accredited by the American National Standards Institute (ANSI). While traditionally involved in the development of messaging standards used by healthcare systems to exchange data, HL7 began to develop structured document standards related to healthcare information systems. In 2003, several organizations approached HL7 to develop a consensus standard to define the necessary functions for an EHR system. The EHR Special Interest Group was promoted to a full EHR Technical Committee (EHR-TC) and subsequently renamed the EHR Work Group (EHR WG). 

The EHR System Functional Model was developed as a Draft Standard and published in 2004, advancing to a full Standard in 2007 and then promoted as a joint ISO/HL7 Standard in 2009, known as ISO/HL7 10781.  The EHR-S FM specifies provider-facing functions and conformance criteria.  The current joint version is ISO/HL7 10781:2023 EHR-S FM R2.1.  

Starting in 2006, the HL7 EHR WG began work on a companion standard, the Personal Health System Functional Model (PHR-S FM).  After first being balloted and published by HL7 in 2009, the PHR-S FM was promoted as a joint ISO/HL7 Standard in 2014, known as ISO/HL7 16527.  The PHR-S FM specifies patient-facing functions and conformance criteria.  The current joint version is known as ISO/HL7 16527:2023 PHR-S FM R2.0.  

More recently the EHR WG has rendered EHR-S FM R2.1.1 and PHR-S FM R2.0.1 in .html, using the Common HL7 Toolset (aka the FHIR IG Publisher).  The latest releases of both FMs will be advanced to ISO once new provisions have been established in the ISO/HL7 Cooperation Agreement.

The HL7 EHR Work Group intends that unique functional profiles be developed by subject matter experts in various care settings to inform developers, purchasers, and other stakeholders of the functional requirements of systems developed for specific domains, care settings, services and specialties.

**University of Nebraska Medical Center – Center for Intelligent Healthcare**

The University of Nebraska Medical Center – Center for Intelligent Healthcare ([UNMC-CIHC](https://www.unmc.edu/cihc/index.html))  is a UNMC Board of Regents approved Center of Excellence of the University of Nebraska (NU) system. The work of the CIHC extends across all four NU campuses to unite clinicians, clinical informaticists, data scientists, and computer scientists to create a world-class organization envisioning and enabling the next generation of health care through three core areas: good data, good design, and optimizing human and computer cognition. The **Patient-Centric Medication List Functional Profile** was developed by subject matter expertise led by UNMC CIHC clinicians, augmented by additional subject matter experts from academic, clinical, electronic health record, industry, professional association, government, and patient sectors.

### EHR WG Co-Chairs and Facilitators

| Role  | Name | Organization | Contact |
| --- | --- | --- | --- |
| **Project Facilitator** | Dr. Aarthi Shanmugavel | American Dental Association | shanmugavela@ada.org |
| **Co-Chair** | Gary Dickinson | EHR Standards Consulting | gary.dickinson@ehr-standards.com |
| **Co-Chair** | Mark Janczewski MD, MPH | Medical Networks, LLC | mark.janczewski@gmail.com |
| **Co-Chair** | John Ritter FHL7, MSc |  | johnritter1@verizon.net |
| **Co-Chair** | Lincoln Weed |  | ldweed424@gmail.com |
| **Co-Chair, Publishing Facilitator** | Michael van der Zel BSc | UMCG | m.van.der.zel@umcg.nl |

### What is a Functional Profile?

The EHR-S FM and the PHR-S FM include lists of all functions that COULD be present in EHR and PHR systems and criteria for achieving that function. Any given EHR-S or PHR-S will perform one or more functions (i.e., a subset) from the FM list (i.e., the superset), depending on the purpose of the system. The select subset of functions and the criteria for conforming to these functions characterize the EHR-S and / or PHR-S capabilities and are referred to as a “functional profile.” The functions and conformance criteria will vary across functional profiles, depending on the operational needs of the system, i.e., what the system is in place to accomplish.

This Personal Health Records Patient-Centric Medication List FP Functional Profile (PCML FP) is based on the HL7® Electronic Health Record System Functional Model (EHR-S FM) Release 2.1.1, 2025 and the HL7® Personal Health Record System Functional Model (PHR-S FM) Release 2.0.1, 2026.  The PCML FP is intended to inform software developers, patients, clinicians, and other interested parties, including government, regulatory agencies, and payers, regarding the desired characteristics, attributes, and functionality of a patient-facing, patient-centric system for the patient to manage their medications list “as taken” by the patient, typically in a home setting. Interoperability and usability specifications are included in the FP to enhance the user (patient or surrogate) experience while leveraging information in electronic health record and other health information technology systems. 

This document is an informative technical report and is designed to detail the “what and why” for the functions and conformance criteria for a patient-facing medication list management software system. The “how” regarding the manner that such functions are implemented in any given personal health record software system is left to software developers and vendors. “How” software vendors implement the functions and conformance criteria in the PCML FP will allow differentiation in the marketplace. Some specific comments are included in the PCML FP to suggest how various PHR-S FM functions and conformance criteria might apply to a patient-facing software system. 

In 2025, members of the HL7 Electronic Health Record Workgroup – Reducing Clinician Burden Workgroup published a description of several years of work to envision and develop a prototype patient-facing medication list management system (Bastola ND, Tcheng JE, Schlossman DM, Windle JR. Framework for Improving Patient Safety: Reference Model for FHIR-Enabled, Patient-Centric Home Medication List Management and Medication Reconciliation. Appl Clin Inform. 2025 Aug;16(4):1136-1145. doi: 10.1055/a-2599-4135. PMID: 40973079; PMCID: PMC12449101). A demonstration prototype of the features and functionality of the system is available on GitHub as described in the manuscript. The intent of the PCML FP is to encourage the development of high-usability patient-facing medication list management systems that communicate, interoperate, and coordinate with health information technologies (including EHR systems) external to the patient-facing environment. 

#### EHR-S Definitions and Standards

ISO/HL7® 10781 EHR-S FM references the International Standards Organization (ISO) ISO/TR-20514 Health Informatics – Electronic health record – Definition, scope and context (1) and states: 

> “The primary purpose of the EHR is to provide a documented record of care that supports present and future care by the same or other clinicians…. Any other purpose for which the health record is used may be considered secondary.” 

> “The Core EHR contains principally clinical information; it is therefore chiefly focused on the primary purpose. The Core EHR is a subset of the Extended EHR. The Extended EHR includes the whole health information landscape; its focus therefore is not only on the primary purpose, but also on all of the secondary purposes as well. The Extended EHR is a superset of the Core EHR.”

#### PHR-S Definitions and Standards

ISO/HL7® 16527 PHR-S FM references the International Standards Organization (ISO) ISO/TR-14292 Health Informatics – Personal health record – Definition, scope and context ([2](https://www.iso.org/standard/84665.html)) and states: 

> “The overarching theme of a PHR-S involves a patient-centric tool that is controlled, for the most part, by the individual PHR Account Holder. A PHR-S should be immediately available electronically and able to link to other systems. The PHR-S provides functionality to help an individual maintain a longitudinal view of his or her health history, and may be comprised of information from a number of sources – e.g., from providers and health plans, as well as from the individual. Data collected by the system is administrative and / or clinical, and the tool may provide access to health-related forms (e.g., Advance Directives) and advice. A PHR-S might also help the individual collect … patient-entered and patient-access data, … medication information … and the like, and might be connected to providers, laboratories, pharmacies, nursing homes, hospitals and other institutions and clinical resources.” 

In this respect, the PCML FP may be regarded as a set of Extended (i.e., not Core) PHR functions.

#### Organization of the HL7® PHR-S Functional Model

The four sections of the function list, reflect content of the EHR Interoperability Model, now integrated in the Functional Model, along with input from several functional profiles of the earlier versions of the Functional Model. Below is a summary description of each of the four sections:

1. Personal Health: Personal Health PHR-S functions are the subset of PHR-S functions that enable an individual to manage information about his or her healthcare. These functions provide direction as to the individual’s ability to interact with a Personal Health Record in such a way so as to individualize the record and maintain a current and accurate record of his or her healthcare activities. The functions include activities such as managing wellness, prevention and encounters. These functions are designed to encourage and allow an individual to participate actively in their healthcare and better access the resources that allow for self-education and monitoring. All functions within the Personal Health Section have an identifier starting with “PH”.
2. Support: Supportive PHR-S functions are the subset of PHR-S functions that assist with the administrative and financial requirements associated with the delivery of healthcare. Supportive PHR-S functions also provide input to systems that perform medical research, promote public health, and seek to improve the quality of healthcare delivered. All functions within the Supportive Section have an identifier starting with “S”.
3. Record Infrastructure: The Record Infrastructure Section consists of functions common to EHR System record management, particularly those functions foundational to managing record lifecycle (origination, attestation, amendment, access/use, translation, transmittal/disclosure, receipt, de-identification, archive…) and record lifespan (persistence, indelibility, continuity, audit, encryption).
The RI and TI Sections are identical between the PHR and EHR System Functional Models, reflecting the need for common and compatible record management and trust infrastructures. Note that there may be some functions more directly applicable to EHR systems than PHR systems.
RI functions are core and foundational to all other functions of the Model (PH, S). RI functions may be implemented within the architecture of a single system or across a tightly coupled suite of systems (applications). All functions within the Record Infrastructure Section have an identifier starting with “RI”.
4. Trust Infrastructure: The Trust Infrastructure (TI) Section consists of functions common to a PHR System infrastructure, particularly those functions foundational to system operations, security, efficiency and data integrity assurance, safeguards for privacy and confidentiality, and interoperability with other systems. TI functions are core and foundational to all other functions of the Model (Care Provision, Care Provision Support, Population Health, Administrative Support and Record Infrastructure). Note extensive reference to TI functions in Overarching Criteria. TI functions may be implemented within the architecture of a single system or across a tightly coupled suite of systems (applications).All functions within the Trust Infrastructure Section have an identifier starting with “TI”.
The RI and TI Sections are identical between the PHR and EHR System Functional Models, reflecting the need for common and compatible record management and trust infrastructures. Note that there may be some functions more directly applicable to EHR systems than PHR systems.

Each function in the HL7® EHR-S Functional Model is identified and described using a set of elements or components as detailed in the example in Table 1 below.

**Table 1: Examples of Functional Model Elements**

| ID | Type | Name | Statement | Description | Conformance Criteria |
| -- | -- | -- | -- | -- | -- |
| CP.1 | H | Manage Clinical History | Manage the patient's clinical history lists used to present summary or detailed information on patient health history. | Patient Clinical History lists are used to present succinct “snapshots” of critical health information including patient history; allergy intolerance and adverse reactions; medications; problems; strengths; immunizations; medical equipment/devices; and patient and family preferences.
| CP.1.4 | F | Manage Problem List | Create and maintain patient-specific problem lists. | A problem list may include, but is not limited to chronic conditions, diagnoses, or symptoms, injury/poisoning (both intentional and unintentional), adverse effects of medical care (e.g., drugs, surgical), functional limitations, visit or stay-specific conditions, diagnoses, or symptoms...
| CP.1.4 | C | | | | 1. The system SHALL provide the ability to manage, as discrete data, all active problems associated with a patient.
| CP.1.4 | C | | | | 2. The system SHALL capture and render a history of all problems associated with a patient.
| CP.1.4 | C | | | | 3. The system SHALL provide the ability to manage relevant dates including the onset date and resolution date of problem.
{: .grid .table-striped}

**Function ID**

This is the unique identifier of a function in the Function List (e.g., CP.1.1) and should be used to identify uniquely the function when referencing functions. The Function ID also serves to identify the section within which the function exists (CP = Care Provision Section) and the hierarchy or relationship between functions (CP.1.1 is at the same level as CP.1.2, CP.1.1 is also a parent of CP.1.1.1 and child of CP.1. In many cases the parent is fully expressed by the children.

**Function Type**

This is an indication of the line item as being a Header (H), Function (F) or Conformance Criteria (C). The Tag (T) is used to identify a new section in the spreadsheet and its related functions in the spreadsheet. A Tag has no directly associated Functions or Criteria.

**Function Name**

This is the name of the Function and while expected to be unique within the Function List; it is not recommended to be used to identify the Function without being accompanied by the Function ID. Example: CP.1.3, Manage Medication List

**Function Statement**

This is a brief statement of the purpose of this function. While not restricted to the use of structured language that is used in the Conformance Criteria (see below), the Statement should clearly identify the purpose and scope of the function. Example: Create and maintain patient-specific medication lists

**Description**

This is a more detailed description of the function, including examples if needed. Example: Medication lists are managed over time, whether over the course of a visit or stay, or the lifetime of a patient. All pertinent dates, including medication start, modification, and end dates are stored. The entire medication history for any medication, including alternative supplements and herbal medications, is viewable. Medication lists are not limited to medication orders recorded by providers, but may include, for example, pharmacy dispense/supply records, patient-reported medications and additional information such as age specific dosage.

#### Conformance Clause

This Profile is based on the HL7® PHR-S Functional Model Release 2.0.1. Key to the Functional Model and derived profiles is the concept of conformance, which is defined (by the EHR-S FM) as “verification that an implementation meets the requirements of a standard or specification”. In the Functional Model and in derived profiles, the general concept of conformance may be expressed in a number of forms. For instance, a profile can be said to conform to the Functional Model if it adheres to the defined rules specified by the Functional Model specification. Similarly, an EHR system may claim conformance to one of these profiles if it meets all the requirements outlined in the profile.

#### Conformance Criteria

Each function in the Function List includes one or more Conformance Criteria. A Conformance Criteria, which exists as normative language in this standard, defines the requirements for conforming to the function. The language used to express a conformance criterion is highly structured with standardized components with set meanings. Example: 1. The system SHALL provide the ability to manage, as discrete data, all active problems associated with a patient.

Each function defined in the Functional Model or profiles is associated with specific conformance criteria, which are statements used to determine if a particular function is met (i.e., “the system SHALL capture, display and report all hearing tests associated with a patient”). Conformance criteria have been developed in accordance with the standards set forth by the EHR Work Group. In order to ensure consistent, unambiguous understanding and application of the Functional Profile, a consistent set of keywords (normative verbs) has been employed to describe conformance requirements.
The key words SHALL, SHALL NOT, SHOULD, and MAY in this document are to be interpreted as described in HL7® PHR-S Functional Model Release 2.0.1, Conformance Clause as detailed in Table 2 below.

**Table 2: Optionality key words**

| | |
| -- | -- |
| SHALL | Indicates a mandatory requirement to be followed (implemented) in order to conform. Synonymous with ‘is required to’ and ‘must’. |
| SHOULD | Indicates an optional recommended action, one that is particularly suitable, without mentioning or excluding others. Synonymous with ‘is permitted and recommended’. |
| MAY | Indicates an optional, permissible action. Synonymous with ‘is permitted’. |
{: .grid .table-striped}

#### Functional Profiles

A “Functional Profile" is a selected set of functions that are applicable for a particular purpose, user, care setting, domain, etc. Functional Profiles help to manage the master list of functions. It is not anticipated that the full Functional Model will apply to any single system implementation. As such, a system does not conform directly to the Functional Model; rather, it conforms to one or more Functional Profiles. See the FM Conformance Clause for additional detail regarding how a system may claim conformance to Functional Profiles.

Functional profiles are the expression of usable subsets of, or modifications or additions to, functions and criteria of the  Functional Model.

The act of creating a Functional Profile is to support specific use case(s) by selecting an applicable subset of functions from the Functional Model list of functions, in effect constraining the model to meet specific requirements. For example, a Functional Profile may be created by a purchaser, to indicate requirements; by a vendor, to indicate the capability of specific products; or by any person/entity wishing to stipulate a desired subset of functions for a particular purpose, including a care setting within a specific realm.

#### Normative Language

Additional clarification is necessary to understand the standardized nomenclature used to describe the actions performed by a system. The excerpt in Table 3, which is from the FM Glossary, illustrates the hierarchical nature of the nomenclature. For example, the term “Capture” is used to describe a function that includes both direct data entry (“Enter”) and indirect data entry (e.g., “Import” from another system). Similarly, “Maintain” is used to describe a function that entails storing, updating, and/or removing data.

**Table 3: "Manage Data" Action-Verbs**

<table class="grid">
<colgroup>
<col style="width: 9%" />
<col style="width: 8%" />
<col style="width: 10%" />
<col style="width: 8%" />
<col style="width: 7%" />
<col style="width: 8%" />
<col style="width: 9%" />
<col style="width: 11%" />
<col style="width: 8%" />
<col style="width: 7%" />
<col style="width: 9%" />
</colgroup>
<thead>
<tr class="header">
<th colspan="11">Manage (Data)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Capture</td>
<td colspan="3">Maintain</td>
<td colspan="3">Render</td>
<td>Exchange</td>
<td colspan="2">Determine</td>
<td>Manage Data Visibility</td>
</tr>
<tr class="even">
<td rowspan="2">Auto-populate<br/>
Enter<br/>
Import<br/>
Receive<br/></td>
<td>Store</td>
<td>Update</td>
<td>Remove</td>
<td rowspan="2">Extract</td>
<td rowspan="2">Present</td>
<td rowspan="2">Transmit</td>
<td rowspan="2">Export<br/>
Import<br/>
Receive<br/>
Transmit<br/></td>
<td rowspan="2">Analyze</td>
<td rowspan="2">Decide</td>
<td rowspan="2">De-Identify/<br/>
Re-Identify<br/>
Hide/<br/>
Unhide<br/>
Mask/<br/>
Unmask<br/></td>
</tr>
<tr class="odd">
<td>Archive<br/>
Backup<br/>
Decrypt<br/>
Encrypt<br/>
Recover<br/>
Restore<br/>
Save<br/></td>
<td>Annotate<br/>
Attest<br/>
Edit<br/>
Harmonize<br/>
Integrate<br/>
Link/Unlink<br/>
Tag/Untag<br/></td>
<td>Delete<br/>
Purge<br/></td>
</tr>
</tbody>
</table>