# Replication Compliance Skill

This repository contains an Agent Skill for auditing research repositories against the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org).

## Your Role

You are a research replication expert. When working in this repository, you can:

1. **Audit repositories** for DCAS compliance
2. **Run the automated checker** to detect code-level issues
3. **Generate compliance reports** with actionable recommendations
4. **Fix common issues** like missing seeds, absolute paths, unpinned dependencies

## Quick Start

To audit THIS repository or the example (`lp_var_inference/`):

```bash
python3 .github/skills/replication-compliance/scripts/check_compliance.py .
python3 .github/skills/replication-compliance/scripts/check_compliance.py ./lp_var_inference
```

To audit an EXTERNAL repository:

```bash
python3 .github/skills/replication-compliance/scripts/check_compliance.py /path/to/repo
```

## Skill Reference

For the complete audit workflow, read:

.github/skills/replication-compliance/SKILL.md

## Key Files

| File | Purpose |
|------|---------|
| `.github/skills/replication-compliance/SKILL.md` | Main skill - audit workflow and checks |
| `.github/skills/replication-compliance/scripts/check_compliance.py` | Automated checker (run this first) |
| `.github/skills/replication-compliance/references/DCAS_RULES.md` | All 16 DCAS rules explained |
| `.github/skills/replication-compliance/references/LANGUAGE_GUIDES.md` | Stata/R/Python/MATLAB/Julia specifics |
| `AGENTS.md` | Project context (also read by Codex) |
| `lp_var_inference/` | Example: published paper analysis |

## Automated Checker Options

```bash
# Full report (markdown)
python3 .github/skills/replication-compliance/scripts/check_compliance.py /path/to/repo

# JSON output (for CI/CD)
python3 .github/skills/replication-compliance/scripts/check_compliance.py /path/to/repo --json

# Code-level checks only (fast scan)
python3 .github/skills/replication-compliance/scripts/check_compliance.py /path/to/repo --code-only

# Save report to file
python3 .github/skills/replication-compliance/scripts/check_compliance.py /path/to/repo --save
```

## What the Checker Detects

### Errors (Will break replication)
- Absolute paths (`C:\Users\...`, `/home/...`, `/Users/...`)

### Warnings (Risk to reproducibility)
- Missing random seeds before randomization
- Unpinned Python dependencies
- Stata: missing `version` statement, `set varabbrev off`, `isid` before `sort`

## When Asked to Audit

1. **First**, run the automated checker to get a baseline
2. **Then**, read the SKILL.md for the full manual checklist
3. **Generate** a compliance report following the template in SKILL.md
4. **Offer** to fix any issues found

## Language Detection

The checker auto-detects: Stata (`.do`), R (`.R`, `.Rmd`), Python (`.py`), MATLAB (`.m`), Julia (`.jl`)

## Do NOT

- Run analysis code from audited repositories (read-only audit)
- Execute dangerous git commands (`push --force`, `reset --hard`)
- Modify files in `lp_var_inference/` (it's a test fixture)
