# Replication Compliance Skill

An [Agent Skill](https://agentskills.io) for auditing research repositories against the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org).

**Repository:** https://github.com/Patrick-Healy/replicator

---

## What It Does

The `replication-compliance` skill enables AI agents to:

1. **Scan any research repository** - Detects Stata, R, Python, MATLAB, Julia projects
2. **Check DCAS compliance** - Audits against all 16 rules systematically
3. **Generate actionable reports** - Prioritized recommendations with code examples
4. **Guide version control** - Safe git workflows for researchers

## Quick Start

With a compatible AI agent (Claude Code, Cursor, Windsurf, etc.):

```
"Check if my repo is DCAS compliant"
"Audit this repository for replication package readiness"
"Is my code ready for AEA submission?"
```

The agent reads `replication-compliance/SKILL.md` and follows the audit workflow.

---

## Example Analysis: lp_var_inference

We tested the skill on [Montiel Olea et al. (2026)](https://github.com/ckwolf92/lp_var_inference) - "Double Robustness of Local Projections and Some Unpleasant VARithmetic".

### Results Summary

| Category | Score | Status |
|----------|-------|--------|
| Data Availability | 4/6 | Partial |
| Code | 3/3 | Pass |
| Documentation | 3/5 | Partial |
| Sharing | 2/3 | Partial |
| **Overall** | **12/17** | **71%** |

### Key Findings

**What's Good:**
- MIT License for code
- All data included (Ramey, Känzig) with proper permissions
- Clear MATLAB structure (55 estimation functions)
- Hardware/software documented

**What's Missing:**
- Data Availability Statement in README
- Archive DOI (Zenodo/ICPSR)
- MATLAB toolbox requirements list

**Full Report:** [`lp_var_inference/COMPLIANCE_REPORT.md`](lp_var_inference/COMPLIANCE_REPORT.md)

---

## Skill Structure

```
replication-compliance/
├── SKILL.md                      # Main skill instructions
├── scripts/
│   └── check_compliance.py       # Automated checker
├── references/
│   ├── DCAS_RULES.md             # All 16 DCAS rules explained
│   ├── LANGUAGE_GUIDES.md        # Stata, R, Python, MATLAB, Julia
│   ├── VERSION_CONTROL_WORKFLOWS.md  # Git workflows (CLI + Desktop)
│   └── GITHUB_MCP_SETUP.md       # GitHub MCP integration
└── assets/
    └── report_template.md        # Report format template
```

## DCAS Rules Covered

| Rules | Category | Checks |
|-------|----------|--------|
| 1-6 | Data | Availability statement, raw data, formats, metadata, citations |
| 7-9 | Code | Transformation scripts, analysis programs, source format |
| 10-12 | Supporting | Instruments, ethics, pre-registration |
| 13 | Documentation | README completeness |
| 14-16 | Sharing | Archive DOI, license, omissions |

## Language Support

The skill includes specific checks for:

- **Stata** - `version`, `set seed`, package bundling, `profile.do`
- **R** - `renv.lock`, `set.seed()`, `sessionInfo()`
- **Python** - `requirements.txt`, virtual environments, seed setting
- **MATLAB** - `startup.m`, `rng()`, toolbox documentation
- **Julia** - `Project.toml`, `Manifest.toml`, `Random.seed!()`

---

## Version Control Safety

The skill classifies git commands by risk level:

| Level | Commands | Action |
|-------|----------|--------|
| Safe | `status`, `log`, `diff`, `branch` | Agent executes |
| Moderate | `add`, `commit`, `push`, `pull` | Agent executes with explanation |
| Dangerous | `reset --hard`, `rebase`, `force push` | User must run manually |
| Forbidden | `push --force origin main` | Never suggested |

GitHub Desktop instructions included for GUI users.

---

## Template Files

This repo also includes the SoDa Replicator template structure:

```
code/           # Analysis code with master scripts (run.do, run.R)
data/           # Raw, interim, analysis data folders
paper/          # Manuscript, results, presentations
documents/      # Ethics, instruments
```

See [`code/README_TEMPLATE.md`](code/README_TEMPLATE.md) for the Social Science Data Editors README schema.

---

## Resources

- [DCAS v1.0](https://datacodestandard.org) - The standard
- [AEA Data Editor](https://aeadataeditor.github.io/aea-de-guidance/) - Journal guidelines
- [Agent Skills](https://agentskills.io) - Skill specification
- [Julian Reif's Stata Guide](https://julianreif.com/guide/) - Best practices

---

## License

MIT License - see [LICENSE](LICENSE)
