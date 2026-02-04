# Replication Compliance Skill

An [Agent Skill](https://agentskills.io) for auditing research repositories against the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org).

> **This repository contains three things:**
> 1. The `replication-compliance` skill (audits any research repo)
> 2. An example analysis on a published paper (`lp_var_inference/`)
> 3. A blank template for new projects (`code/`, `data/`, `paper/`)

**Repository:** https://github.com/Patrick-Healy/replicator

---

## What It Does

The `replication-compliance` skill enables AI agents to:

1. **Scan any research repository** - Reads files and folder structure to detect languages (Stata, R, Python, MATLAB, Julia) and key documents. Does not run your code unless explicitly asked.
2. **Check DCAS compliance** - Audits against all 16 rules by checking for files, code patterns (e.g., `set.seed()`), and metadata.
3. **Generate actionable reports** - Prioritized recommendations with code examples to fix gaps.
4. **Guide version control** - Safe git workflows with dangerous commands flagged for manual execution.

---

## Setup

### Option 1: Clone this repository

```bash
git clone https://github.com/Patrick-Healy/replicator.git
```

Then point your agent to the skill:

```
"Using the instructions in /path/to/replicator/replication-compliance/SKILL.md,
audit my repository at /path/to/my-project for DCAS compliance"
```

### Option 2: Copy just the skill folder

Copy `replication-compliance/` into your project or a shared location. The skill works standalone - the template folders (`code/`, `data/`, `paper/`) are not required.

---

## Quick Start

With a compatible AI agent (Claude Code, Cursor, Windsurf, etc.):

```
"Check if my repo is DCAS compliant"
"Audit this repository for replication package readiness"
"Is my code ready for AEA submission?"
```

The agent reads `SKILL.md` (the instruction file) and follows the audit workflow. You don't need to read `SKILL.md` yourself - just point the agent to it.

**Note:** The skill can audit any repository structure. The included template is recommended but not required.

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

## Skill Architecture

```
replication-compliance/
├── SKILL.md                      # Agent instructions: defines audit workflow
├── scripts/
│   └── check_compliance.py       # Automated checker: fast file/pattern searches
├── references/
│   ├── DCAS_RULES.md             # All 16 DCAS rules explained
│   ├── LANGUAGE_GUIDES.md        # Stata, R, Python, MATLAB, Julia best practices
│   ├── VERSION_CONTROL_WORKFLOWS.md  # Git workflows (CLI + GitHub Desktop)
│   └── GITHUB_MCP_SETUP.md       # GitHub MCP server integration
└── assets/
    └── report_template.md        # Report format template
```

### How the Components Work Together

| Component | Role |
|-----------|------|
| `SKILL.md` | High-level prompt defining the step-by-step audit workflow. The agent reads this to understand what to check and how to report findings. |
| `check_compliance.py` | Python script the agent can run for fast automated checks (file existence, regex searches for seeds, license detection). Optional - agent can also check manually. |
| `references/` | Supporting documentation the agent consults for language-specific guidance and DCAS rule details. |

---

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

## Template Files (Optional)

This repo includes a best-practice project structure from SoDa Labs. **Use of this template is recommended but not required** - the skill can audit any repository structure.

```
code/           # Analysis code with master scripts (run.do, run.R)
data/           # Raw, interim, analysis data folders
paper/          # Manuscript, results, presentations
documents/      # Ethics, instruments
```

See [`code/README_TEMPLATE.md`](code/README_TEMPLATE.md) for the Social Science Data Editors README schema.

---

## Contributing

Contributions to improve the skill are welcome.

### To add a new compliance check:
1. Add the logic to the workflow in `SKILL.md`
2. If automatable, add a function to `scripts/check_compliance.py`
3. Test by running a full audit on an example repository

### To add a new language:
1. Add a section to `references/LANGUAGE_GUIDES.md`
2. Update detection logic in `check_compliance.py`
3. Add language-specific checks to `SKILL.md`

### To improve documentation:
- `references/DCAS_RULES.md` - Rule explanations and examples
- `references/VERSION_CONTROL_WORKFLOWS.md` - Git guidance

---

## Resources

- [DCAS v1.0](https://datacodestandard.org) - The standard
- [AEA Data Editor](https://aeadataeditor.github.io/aea-de-guidance/) - Journal guidelines
- [Agent Skills](https://agentskills.io) - Skill specification
- [Julian Reif's Stata Guide](https://julianreif.com/guide/) - Best practices

---

## License

MIT License - see [LICENSE](LICENSE)
