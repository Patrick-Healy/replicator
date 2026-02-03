# Plan: Replication Compliance Skill

## Overview

Create an Agent Skill that allows users to compare their repository (at any state) against the DCAS (Data and Code Availability Standard) baseline, generating a compliance report with actionable recommendations.

---

## Skill Structure

```
replication-compliance/
├── SKILL.md                    # Main skill instructions
├── scripts/
│   ├── check_compliance.py     # Main compliance checker
│   ├── check_data.py           # Data availability checks
│   ├── check_code.py           # Code organization checks
│   └── generate_report.py      # Report generation
├── references/
│   ├── DCAS_RULES.md           # Complete DCAS rules reference
│   ├── CHECKLIST.md            # Detailed checklist template
│   └── LANGUAGE_GUIDES.md      # Stata/R/Python specific guidance
└── assets/
    └── report_template.md      # Template for compliance reports
```

---

## SKILL.md Design

### Frontmatter

```yaml
---
name: replication-compliance
description: Audit research repositories against the Data and Code Availability Standard (DCAS). Use when checking replication package compliance, preparing submissions, or reviewing code organization for reproducibility.
license: MIT
metadata:
  author: sodalabsio
  version: "1.0"
  standard: DCAS v1.0
---
```

### Key Sections

1. **When to Use** - Triggers for activation
2. **How to Audit** - Step-by-step compliance checking
3. **Report Format** - Structured output specification
4. **Fix Suggestions** - Common remediation patterns

---

## Compliance Check Categories

### 1. Data Availability [DCAS 1-6]

| Check | Method | Pass Criteria |
|-------|--------|---------------|
| Data Availability Statement | Look for README section | Contains access details |
| Raw data documented | Check `data/raw/*/README.md` | Each source has documentation |
| Analysis data present | Check `data/analysis/` | Files exist or regenerable |
| Data format | File extensions | Standard formats (CSV, DTA, RDS, etc.) |
| Metadata/codebook | Search for codebook files | Variable descriptions exist |
| Data citations | Parse README | All sources cited |

### 2. Code [DCAS 7-9]

| Check | Method | Pass Criteria |
|-------|--------|---------------|
| Data transformation scripts | Check `dataprep/` or equivalent | Scripts exist |
| Analysis scripts | Check `analysis/` or equivalent | Scripts exist |
| Source format | File extensions | No compiled binaries |
| Master script | Look for `run.do`, `run.R`, `main.py` | Entry point exists |

### 3. Supporting Materials [DCAS 10-12]

| Check | Method | Pass Criteria |
|-------|--------|---------------|
| Survey instruments | Check `documents/` | Present if applicable |
| Ethics documentation | Search README/documents | IRB noted if applicable |
| Pre-registration | Search README | Linked if applicable |

### 4. Documentation [DCAS 13]

| Check | Method | Pass Criteria |
|-------|--------|---------------|
| README exists | File check | README.md present |
| Software requirements | Parse README | Versions listed |
| Hardware requirements | Parse README | Memory/time documented |
| Replication instructions | Parse README | Steps provided |

### 5. Sharing [DCAS 14-16]

| Check | Method | Pass Criteria |
|-------|--------|---------------|
| License file | File check | LICENSE exists |
| Archive location | Parse README | DOI or repository noted |
| Omissions documented | Parse README | Exceptions explained |

---

## Report Output Format

```markdown
# Replication Compliance Report

**Repository:** [path]
**Date:** [timestamp]
**Standard:** DCAS v1.0

## Summary

| Category | Score | Status |
|----------|-------|--------|
| Data Availability | 4/6 | ⚠️ Partial |
| Code | 3/3 | ✅ Pass |
| Supporting Materials | 2/3 | ⚠️ Partial |
| Documentation | 3/5 | ⚠️ Partial |
| Sharing | 2/3 | ⚠️ Partial |
| **Overall** | **14/20** | **⚠️ 70%** |

## Detailed Findings

### ✅ Passing Checks
- [x] Master script exists: `run.do`
- [x] Data transformation scripts in `dataprep/`
- [x] License file present

### ⚠️ Warnings
- [ ] Data Availability Statement incomplete
- [ ] Expected runtime not documented

### ❌ Missing Requirements
- [ ] No codebook/variable documentation
- [ ] Raw data sources not cited

## Recommendations

### Priority 1 (Required for submission)
1. Add Data Availability Statement to README
2. Create codebook for analysis variables

### Priority 2 (Recommended)
1. Document expected runtime
2. Add hardware requirements

## Files Analyzed
- README.md
- code/run.do
- data/raw/*/README.md
- ...
```

---

## Implementation Approach

### Option A: Script-Based (Recommended)

Python scripts that:
1. Scan directory structure
2. Parse README files for required sections
3. Check file existence and formats
4. Generate structured report

**Pros:** Automated, consistent, comprehensive
**Cons:** Requires Python

### Option B: Agent-Guided Checklist

Agent follows checklist manually using file reads

**Pros:** No dependencies, flexible
**Cons:** Slower, less consistent

### Hybrid Approach

- Scripts for automated checks
- Agent interprets edge cases
- Agent generates recommendations

---

## Language-Specific Checks

### Stata
- [ ] `version` statement in master script
- [ ] `set varabbrev off`
- [ ] Packages in `libraries/stata/` or documented
- [ ] Forward slashes in paths

### R
- [ ] `renv.lock` or package documentation
- [ ] `set.seed()` for reproducibility
- [ ] `sessionInfo()` logged

### Python
- [ ] `requirements.txt` or `environment.yml`
- [ ] Random seeds set
- [ ] Virtual environment documented

---

## User Invocation Examples

```
User: "Check if my repo is ready for AEA submission"
→ Activates skill, runs full compliance audit

User: "What's missing from my replication package?"
→ Runs audit, focuses on missing requirements

User: "Generate a DCAS compliance report"
→ Full audit with detailed report

User: "Is my data documentation complete?"
→ Runs data-specific checks only
```

---

## Next Steps

1. **Create SKILL.md** with complete instructions
2. **Build reference files:**
   - DCAS_RULES.md - Complete rule definitions
   - CHECKLIST.md - Detailed checklist
   - LANGUAGE_GUIDES.md - Language-specific guidance
3. **Write Python scripts** for automated checking
4. **Create report template** in assets/
5. **Test** on sample repositories
6. **Document** usage patterns

---

## Integration with SoDa Replicator

The skill should:
- Recognize SoDa Replicator folder structure
- Use existing `checklist.md` as baseline
- Generate reports compatible with GitHub Actions
- Support incremental checking (pre-commit hooks)
