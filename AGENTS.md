# AGENTS.md

> Project context for AI coding agents. See [agents.md](https://agents.md/) specification.

## Project Overview

This repository contains the **replication-compliance** Agent Skill for auditing research repositories against the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org).

## Repository Structure

```
.github/skills/replication-compliance/   # The skill (Agent Skills standard)
lp_var_inference/                        # Example analysis on published paper
code/, data/, paper/                     # Optional project template
```

## The Skill

**Location:** `.github/skills/replication-compliance/SKILL.md`

**Purpose:** Audit any research repository for DCAS compliance and generate actionable reports.

**Supported Languages:** Stata, R, Python, MATLAB, Julia

## How to Use the Skill

1. Read `.github/skills/replication-compliance/SKILL.md` for the full workflow
2. The skill reads files but does not run code unless explicitly asked
3. Use `scripts/check_compliance.py` for automated checks (optional)
4. Generate a compliance report following `assets/report_template.md`

## Key Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Main instructions - defines audit workflow |
| `scripts/check_compliance.py` | Automated file/pattern checker |
| `references/DCAS_RULES.md` | All 16 DCAS rules explained |
| `references/LANGUAGE_GUIDES.md` | Language-specific best practices |

## Commands

```bash
# Run automated compliance check
python .github/skills/replication-compliance/scripts/check_compliance.py /path/to/repo

# View example report
cat lp_var_inference/COMPLIANCE_REPORT.md
```

## Code Style

- Python: Follow PEP 8
- Markdown: Use GitHub-flavored markdown
- Keep SKILL.md under 500 lines for token efficiency

## Contributing

- Add new checks to both `SKILL.md` and `check_compliance.py`
- Add new languages to `references/LANGUAGE_GUIDES.md`
- Test changes on a real repository before committing

## Boundaries

- Do not modify files in `lp_var_inference/` (example repo, read-only)
- The skill audits but does not auto-fix compliance issues
- Dangerous git commands must be flagged for manual execution
