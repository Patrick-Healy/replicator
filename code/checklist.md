# Replication Checklist

[Note: This checklist aligns with the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org). Rule numbers in brackets [#] reference specific DCAS requirements. Adapt to your project context.]

Claude, check only elements selected with `[x]`.

---

## Data Availability [DCAS 1-6]

### Data Availability Statement [1]
- [ ] Data Availability Statement included in README_TEMPLATE.md
- [ ] Access steps documented for each data source
- [ ] Monetary costs (if any) noted
- [ ] Time required for access noted
- [ ] Contact information for data providers included

### Raw Data [2]
- [ ] Raw data files included in `../data/raw/`
- [ ] Each data source has its own subdirectory
- [ ] Documentation/codebook included with each source
- [ ] Exceptions (confidential/proprietary data) explained in README

### Analysis Data [3]
- [ ] Analysis datasets included in `../data/analysis/`
- [ ] OR: Can be reproduced from raw data within reasonable time

### Data Format [4]
- [ ] Data in standard formats (CSV, DTA, RDS, Parquet, etc.)
- [ ] Open formats preferred where possible

### Metadata [5]
- [ ] Variable descriptions provided (codebook or documentation)
- [ ] Allowed values/ranges documented
- [ ] Missing value codes explained

### Data Citation [6]
- [ ] All data sources cited in README and paper
- [ ] Citations include: author, title, year, publisher, URL, access date

---

## Code [DCAS 7-9]

### Data Transformation [7]
- [x] Scripts transform raw data to analysis data
- [x] Data preparation in `dataprep/` subdirectories by source
- [x] Interim data written to `../data/interim/`
- [x] Final analysis data written to `../data/analysis/`

### Analysis Programs [8]
- [x] Analysis scripts in `analysis/` directory
- [ ] All computational results reproducible (regressions, simulations, figures)
- [ ] Results exported to `../paper/results/tables/` and `../paper/results/figures/`

### Code Format [9]
- [x] Source code provided (not compiled/binary)
- [x] Scripts have descriptive names
- [ ] Master script (`run.do` or `run.R`) executes entire pipeline

---

## Supporting Materials [DCAS 10-12]

### Instruments [10]
- [ ] Survey instruments included (if applicable): `documents/survey.pdf`
- [ ] Experiment instructions included (if applicable)
- [ ] Subject selection criteria documented

### Ethics [11]
- [ ] IRB/Ethics approval number documented
- [ ] Approval documentation included (if applicable)
- [ ] N/A: No human subjects research

### Pre-Registration [12]
- [ ] Pre-registration cited and linked (if applicable)
- [ ] Registry name and number documented
- [ ] N/A: Not a pre-registered study

---

## Documentation [DCAS 13]

### README Requirements
- [ ] README follows Social Science Data Editors template
- [ ] Data Availability Statement included
- [ ] All software dependencies listed with versions
- [ ] Hardware requirements specified
- [ ] Expected runtime documented
- [ ] Step-by-step replication instructions provided

### Computational Requirements
- [ ] Software versions specified (Stata 18, R 4.3, Python 3.11, etc.)
- [ ] Package versions locked (renv.lock, libraries/stata/)
- [ ] Memory requirements noted
- [ ] Storage requirements noted
- [ ] Multi-core/cluster requirements noted (if applicable)

---

## Sharing [DCAS 14-16]

### Location [14]
- [ ] Package archived in acceptable repository
- [ ] DOI obtained (Zenodo, ICPSR, Dataverse, etc.)

### License [15]
- [ ] LICENSE file included
- [ ] License permits replication by unconnected researchers
- [ ] Recommended: AEA mixed license (MIT for code, CC-BY for data)

### Omissions [16]
- [ ] Any omissions clearly documented in README
- [ ] Legal/contractual reasons for omissions explained
- [ ] Alternative access paths provided where possible

---

## Code Quality & Reproducibility

### Organization
- [x] Code reads data from `../data/` using relative paths
- [x] Raw data files never modified
- [ ] Helper functions in `programs/` directory
- [ ] User-written packages in `libraries/` directory

### Stata-Specific
- [ ] `version` statement in master script (e.g., `version 18`)
- [ ] `set varabbrev off` to prevent errors
- [ ] `isid` checks before non-unique sorts
- [ ] `set seed` for reproducible randomization
- [ ] Forward slashes in all pathnames

### R-Specific
- [ ] `renv` initialized and `renv.lock` current
- [ ] `set.seed()` for reproducible randomization
- [ ] Session info logged (`sessionInfo()`)

### Python-Specific
- [ ] `requirements.txt` or `environment.yml` included
- [ ] Random seeds set (`random.seed()`, `np.random.seed()`)
- [ ] Virtual environment documented

### Verification
- [ ] Assertions verify key results match manuscript
- [ ] Checksums verify data integrity (optional)
- [ ] Code tested on fresh copy of package

---

## Final Checklist

Before submission:

- [ ] Delete `_install_stata_packages.do` (locks package versions)
- [ ] Delete any debugging/scratch code
- [ ] Delete `../data/interim/` and `../data/analysis/`
- [ ] Run master script to regenerate all outputs
- [ ] Verify outputs match manuscript exactly
- [ ] Fill out README_TEMPLATE.md completely
- [ ] Include LICENSE file
- [ ] Archive in repository and obtain DOI
