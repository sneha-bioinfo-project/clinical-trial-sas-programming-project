# SDTM to ADaM Clinical Programming Project

## Clinical Trial Data Processing and Analysis Using SAS

### Overview

This project demonstrates an end-to-end clinical programming workflow using SAS Studio, following industry-standard concepts commonly used in pharmaceutical and biotechnology clinical trials.

The workflow begins with SDTM-style clinical trial datasets and progresses through data cleaning, validation, quality control, subject-level analysis dataset creation (ADSL), and clinical reporting.

The objective of this project is to simulate the responsibilities of a Clinical SAS Programmer by applying standard clinical data management and analysis techniques to trial data.

---

## Project Objectives

* Import SDTM clinical datasets into SAS
* Perform data cleaning and standardization
* Execute validation and quality control checks
* Detect duplicate and missing records
* Create an ADaM-style subject-level analysis dataset (ADSL)
* Derive analysis variables and population flags
* Generate demographic, safety, laboratory, and vital sign reports
* Produce submission-ready outputs for downstream statistical analysis

---

## Clinical Domains Included

| Domain | Description        |
| ------ | ------------------ |
| DM     | Demographics       |
| AE     | Adverse Events     |
| DS     | Disposition        |
| LB     | Laboratory Results |
| VS     | Vital Signs        |

---

## Project Architecture

```text
Raw SDTM Data
     │
     ▼
01_import.sas
     │
     ▼
02_clean.sas
     │
     ▼
03_validation.sas
     │
     ▼
04_analysis_adam.sas
     │
     ▼
ADSL Dataset
     │
     ▼
05_reports.sas
     │
     ▼
Clinical Study Report PDF
```

---

## SAS Programs

### 01_import.sas

Imports SDTM datasets into SAS.

Key Activities:

* Dataset ingestion
* Dataset verification
* Initial record review

---

### 02_clean.sas

Performs data cleaning and standardization.

Key Activities:

* Character value standardization
* Missing value review
* Data quality checks
* Domain-level preparation

Domains Processed:

* AE
* DM
* DS
* LB
* VS

---

### 03_validation.sas

Performs validation and quality control procedures.

Quality Checks:

* Dataset structure review
* Record count verification
* Duplicate subject detection
* Missing data assessment
* Demographic consistency checks
* Adverse event validation
* Laboratory value review
* Vital sign review

---

### 04_analysis_adam.sas

Creates an ADaM-style ADSL dataset.

Derived Variables:

| Variable | Description                     |
| -------- | ------------------------------- |
| AGEGR1   | Age Category (<65 / >=65)       |
| SAFFL    | Safety Population Flag          |
| ITTFL    | Intent-to-Treat Population Flag |

Quality Control:

* One record per subject
* Subject uniqueness verification
* Population flag validation

---

### 05_reports.sas

Generates clinical study outputs and summary reports.

Outputs Include:

* Demographic summaries
* Treatment arm distributions
* Safety population summaries
* Adverse event summaries
* Laboratory summaries
* Vital sign summaries
* Subject listings

---

## Key Study Results

### Subject Population

| Metric            | Count |
| ----------------- | ----- |
| Total Subjects    | 306   |
| Unique Subjects   | 306   |
| Safety Population | 254   |
| Screen Failures   | 52    |

---

### Treatment Distribution

| Treatment Arm        | Subjects |
| -------------------- | -------- |
| Placebo              | 86       |
| Xanomeline Low Dose  | 84       |
| Xanomeline High Dose | 84       |
| Screen Failure       | 52       |

---

### Demographics

* Female Subjects: 179 (58.5%)
* Male Subjects: 127 (41.5%)

Age Groups:

* <65 Years: 42 Subjects
* ≥65 Years: 264 Subjects

---

### Adverse Event Summary

Total Adverse Events:

* Mild: 770
* Moderate: 378
* Severe: 43

Total AE Records Reviewed:

* 1,191

---

### Laboratory Data Summary

Laboratory Records:

* 58,700 observations

Highlighted Tests:

* ALT
* AST

Summary statistics generated:

* Mean
* Median
* Minimum
* Maximum
* Missing counts

---

### Vital Signs Summary

Vital Sign Records:

* 29,635 observations

Parameters Reviewed:

* Systolic Blood Pressure
* Diastolic Blood Pressure
* Pulse Rate
* Temperature
* Height
* Weight

---

## Technologies Used

* SAS Studio
* Base SAS
* PROC SQL
* PROC FREQ
* PROC MEANS
* PROC SORT
* DATA Step Programming
* Clinical Data Standards Concepts

---

## Clinical Programming Skills Demonstrated

### SDTM Processing

* Clinical domain integration
* Subject-level data review

### Data Management

* Data cleaning
* Standardization
* Missing data handling

### Quality Control

* Duplicate detection
* Validation checks
* Consistency review

### ADaM Development

* Subject-level dataset creation
* Analysis variable derivation
* Population flag generation

### Clinical Reporting

* Demographic summaries
* Safety summaries
* Laboratory reporting
* Vital sign reporting

---

## Output Deliverables

* Cleaned Clinical Datasets
* Validation Reports
* ADaM-Style ADSL Dataset
* Clinical Study Report (PDF)

---

## Author

Sneha Suresh

Clinical Programming • SAS • Clinical Data Analysis • Bioinformatics
