# [TITLE OF PAPER]

## Authors
- [Author 1], [Affiliation], [Email]
- [Author 2], [Affiliation], [Email]

## Overview

This replication package reproduces all tables and figures in "[Paper Title]" ([Journal], [Year]). The package contains [describe briefly: raw data, analysis code, etc.].

**Suggested citation:**
> [Authors]. [Year]. "Replication Package for: [Title]." [Repository], [DOI].

---

## Data Availability Statement

> [DCAS Rule 1: Provide detailed information so an independent researcher can replicate data access steps]

### Data Sources

| Data Source | Files | Provided | Access |
|-------------|-------|----------|--------|
| [Source 1]  | `data/raw/source1/` | Yes | Public |
| [Source 2]  | `data/raw/source2/` | No | Restricted - see below |

### Publicly Available Data

**[Source 1 Name]**
- **Citation:** [Full citation]
- **URL:** [Download URL]
- **Date accessed:** [Date]
- **Files:** `filename1.csv`, `filename2.csv`

### Restricted/Proprietary Data

**[Source 2 Name]**
- **Citation:** [Full citation]
- **Access requirements:**
  - [ ] Application required at [URL]
  - [ ] Fees: [Amount] for [license type]
  - [ ] Estimated time for access: [X weeks/months]
- **Contact:** [Data provider contact]
- **Alternative:** [Any publicly available alternative]

### Statement on Rights

- [ ] I certify that the author(s) have legitimate access to all data used
- [ ] All data are licensed for redistribution, OR specific exceptions noted above

---

## Computational Requirements

> [DCAS Rule 13: List all software, hardware dependencies, and expected runtime]

### Software Requirements

**Primary Language:** [Stata 18 / R 4.3 / Python 3.11]

| Software | Version | Required | Notes |
|----------|---------|----------|-------|
| Stata    | 18.0    | Yes      | MP preferred for large datasets |
| R        | 4.3.0   | Yes      | |
| Python   | 3.11    | Optional | For supplementary analysis |
| LaTeX    | TeX Live 2023 | No | For manuscript only |

### Stata Packages

All packages are bundled in `libraries/stata/`. If installing manually:

```stata
ssc install reghdfe
ssc install ftools
ssc install estout
net install regsave, from("https://raw.githubusercontent.com/reifjulian/regsave/master")
```

### R Packages

Managed via `renv`. To install:

```r
renv::restore()
```

Or install manually:

```r
install.packages(c("tidyverse", "fixest", "data.table", "haven", "modelsummary"))
```

### Python Packages

```bash
pip install -r requirements.txt
```

### Hardware Requirements

- **Memory:** [X] GB RAM minimum
- **Storage:** [X] GB free disk space
- **Processor:** [Any modern CPU / Multi-core recommended]
- **Operating System:** Tested on [Windows 11, macOS 14, Ubuntu 22.04]

### Expected Runtime

| Script | Time | Hardware |
|--------|------|----------|
| `run.do` (full pipeline) | ~[X] hours | [Describe machine] |
| Data preparation only | ~[X] minutes | |
| Analysis only | ~[X] minutes | |

---

## Description of Code

> [DCAS Rules 7-9: Programs for data transformation and analysis]

### Directory Structure

```
code/
├── run.do                 # Master script (Stata) - executes full pipeline
├── run.R                  # Master script (R) - executes full pipeline
├── dataprep/              # Data preparation scripts
│   ├── source1/           # Clean [Source 1] data
│   └── source2/           # Clean [Source 2] data
├── analysis/              # Analysis scripts
├── programs/              # Helper functions
└── libraries/             # Bundled packages
    ├── stata/
    └── R/
```

### Script Descriptions

| Script | Description | Inputs | Outputs |
|--------|-------------|--------|---------|
| `dataprep/source1/clean.do` | Cleans raw [Source 1] data | `data/raw/source1/*.csv` | `data/interim/source1.dta` |
| `dataprep/create_analysis.do` | Merges datasets | `data/interim/*.dta` | `data/analysis/main.dta` |
| `analysis/regressions.do` | Main regression analysis | `data/analysis/main.dta` | `paper/results/tables/table1.tex` |
| `analysis/figures.do` | Generates figures | `data/analysis/main.dta` | `paper/results/figures/*.pdf` |

---

## Description of Data

> [DCAS Rules 2-6: Raw data, analysis data, format, metadata, citations]

### Data Files

| Folder | File | Description | Format | Observations | Variables |
|--------|------|-------------|--------|--------------|-----------|
| `data/raw/source1/` | `raw_data.csv` | [Description] | CSV | [N] | [K] |
| `data/interim/` | `cleaned.dta` | [Description] | Stata 18 | [N] | [K] |
| `data/analysis/` | `main.dta` | Primary analysis dataset | Stata 18 | [N] | [K] |

### Codebook

See `data/analysis/codebook.xlsx` for variable definitions, or:

| Variable | Description | Values/Range | Source |
|----------|-------------|--------------|--------|
| `outcome` | Primary outcome variable | 0-100 | Survey Q1 |
| `treatment` | Treatment indicator | 0/1 | Random assignment |
| `age` | Respondent age | 18-99 | Survey Q5 |

---

## Instructions for Replication

### Quick Start

1. **Configure paths:**
   - Stata: Edit line [X] of `run.do` to set `$PROJECT`
   - R: Scripts auto-detect paths if run from `code/` directory

2. **Install packages:**
   - Stata: Packages bundled in `libraries/stata/`
   - R: Run `renv::restore()`

3. **Execute:**
   ```stata
   cd "/path/to/code"
   do run.do
   ```
   OR
   ```r
   setwd("/path/to/code")
   source("run.R")
   ```

4. **Outputs:**
   - Tables: `paper/results/tables/`
   - Figures: `paper/results/figures/`

### Step-by-Step Instructions

1. **Data preparation** (if raw data changes):
   ```stata
   do dataprep/source1/clean.do
   do dataprep/source2/clean.do
   do dataprep/create_analysis.do
   ```

2. **Main analysis:**
   ```stata
   do analysis/regressions.do
   do analysis/figures.do
   ```

### Reproducing Specific Results

| Table/Figure | Script | Line | Notes |
|--------------|--------|------|-------|
| Table 1 | `analysis/regressions.do` | 45-80 | Summary statistics |
| Table 2 | `analysis/regressions.do` | 82-150 | Main results |
| Figure 1 | `analysis/figures.do` | 20-55 | |

---

## Supporting Materials

> [DCAS Rules 10-12: Instruments, ethics, pre-registration]

### Survey Instruments / Experiment Materials

- [ ] Survey instrument: `documents/survey.pdf`
- [ ] Experiment instructions: `documents/instructions.pdf`
- [ ] Subject selection criteria: [Describe]

### Ethics Approval

- [ ] IRB/Ethics approval number: [Number]
- [ ] Institution: [Name]
- [ ] Date approved: [Date]
- [ ] Documentation: `documents/ethics_approval.pdf`

### Pre-Registration

- [ ] Registry: [AEA RCT Registry / OSF / EGAP / etc.]
- [ ] Registration number: [Number]
- [ ] URL: [Link]
- [ ] Date registered: [Date]

---

## License

> [DCAS Rule 15]

This replication package is licensed under [LICENSE NAME]. See `LICENSE` file.

**Recommended:** Use the [AEA mixed license](https://github.com/AEADataEditor/aea-de-guidance/blob/master/template-LICENSE.md) which covers both code (MIT) and data (CC-BY 4.0).

---

## Acknowledgments

- [Funding sources]
- [Data providers]
- [Research assistants]
- [Computational resources]

---

## References

[Include full citations for all data sources per DCAS Rule 6]
