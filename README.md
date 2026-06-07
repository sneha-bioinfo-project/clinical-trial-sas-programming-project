# 🧬 SDTM → ADaM Clinical Programming Project

## 📊 Project Snapshot

| Metric | Value |
|----------|---------|
| Subjects | 306 |
| Safety Population | 254 |
| Screen Failures | 52 |
| AE Records | 1,191 |
| Lab Records | 58,700 |
| Vital Sign Records | 29,635 |

---

## 🏗 Clinical Programming Workflow

```text
Raw SDTM Domains
│
├── DM (Demographics)
├── AE (Adverse Events)
├── DS (Disposition)
├── LB (Laboratory)
└── VS (Vital Signs)

        ↓

01_import.sas

        ↓

02_clean.sas

        ↓

03_validation.sas

        ↓

04_analysis_adam.sas

        ↓

ADSL Dataset

        ↓

05_reports.sas

        ↓

Clinical Study Report (PDF)
```

---

## 🎯 Project Objectives

✔ Import SDTM clinical datasets

✔ Perform cleaning and standardization

✔ Conduct validation and QC checks

✔ Create ADaM-style ADSL

✔ Derive analysis variables

✔ Generate clinical reports

✔ Simulate real-world Clinical SAS Programmer workflow

---

## 📁 Repository Structure

```text
clinical-programming-project/
│
├── data/
│   ├── ae.csv
│   ├── dm.csv
│   ├── ds.csv
│   ├── lb.csv
│   └── vs.csv
│
├── sas/
│   ├── 01_import.sas
│   ├── 02_clean.sas
│   ├── 03_validation.sas
│   ├── 04_analysis_adam.sas
│   └── 05_reports.sas
│
├── output/
│   └── clinical_study_reports.pdf
│
└── README.md
```

---

## 🧪 Clinical Domains

| Domain | Description |
|----------|------------|
| DM | Demographics |
| AE | Adverse Events |
| DS | Disposition |
| LB | Laboratory |
| VS | Vital Signs |

---

## 📈 Key Outputs

### ADSL Dataset

| Variable | Description |
|-----------|------------|
| AGEGR1 | Age Group |
| SAFFL | Safety Flag |
| ITTFL | Intent-To-Treat Flag |

---

## 📋 Results Summary

### Demographics

| Category | Count |
|-----------|--------|
| Female | 179 |
| Male | 127 |

### Treatment Arms

| Arm | Subjects |
|-------|-----------|
| Placebo | 86 |
| Xanomeline Low Dose | 84 |
| Xanomeline High Dose | 84 |
| Screen Failure | 52 |

### Adverse Events

| Severity | Count |
|------------|--------|
| Mild | 770 |
| Moderate | 378 |
| Severe | 43 |

---

## 🛠 Technologies

- SAS Studio
- Base SAS
- PROC SQL
- PROC FREQ
- PROC MEANS
- PROC SORT
- DATA Step Programming

---

## 🎓 Skills Demonstrated

- Clinical Data Management
- SDTM Processing
- ADaM Development
- Data Validation
- Quality Control
- Clinical Reporting
- Statistical Programming

---

## 👩‍💻 Author

**Sneha Suresh**

M.Sc. Bioinformatics

Aspiring Clinical SAS Programmer | Clinical Data Analyst
