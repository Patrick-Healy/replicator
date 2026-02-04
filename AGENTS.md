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

## Testing

Test the skill by running it against the included example:

```bash
# Run automated checker on example repo
python .github/skills/replication-compliance/scripts/check_compliance.py ./lp_var_inference

# Compare output to reference report
diff <(python scripts/check_compliance.py ./lp_var_inference) lp_var_inference/COMPLIANCE_REPORT.md
```

The `lp_var_inference/` directory serves as a test fixture - do not modify it.

## PR & Commit Guidelines

Follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New feature (e.g., `feat: add Julia language support`)
- `fix:` - Bug fix (e.g., `fix: correct MATLAB file detection`)
- `docs:` - Documentation only
- `refactor:` - Code change that neither fixes nor adds
- `test:` - Adding or updating tests

PRs should:
- Be small and focused on one change
- Include updated tests if adding checks
- Update SKILL.md and check_compliance.py together

## Security

**Read-only by default:** The skill reads files but does not modify them unless explicitly asked.

**Never execute user code:** Do not run scripts found in audited repositories.

**Sanitize paths:** Validate all file paths to prevent traversal attacks.

**Protect secrets:** Do not log or display contents of files that may contain API keys, passwords, or credentials (e.g., `.env`, `config.json`).

**Git safety:** Dangerous commands are forbidden for agent execution:
- `git push --force`
- `git reset --hard`
- `git rebase`
- `git clean -f`

These must be flagged for manual user execution with warnings.

## Contributing

- Add new checks to both `SKILL.md` and `check_compliance.py`
- Add new languages to `references/LANGUAGE_GUIDES.md`
- Test changes on a real repository before committing

## Boundaries

- Do not modify files in `lp_var_inference/` (example repo, read-only)
- The skill audits but does not auto-fix compliance issues
- Dangerous git commands must be flagged for manual execution
