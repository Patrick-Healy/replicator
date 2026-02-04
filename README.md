# Replication Compliance Skill

An [Agent Skill](https://agentskills.io) for auditing research repositories against the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org).

**Version:** 1.2 | **Supported Tools:** Gemini CLI, Claude Code, OpenAI Codex, GitHub Copilot, Cursor

---

## Quick Install

**One-liner (recommended):**
```bash
curl -fsSL https://raw.githubusercontent.com/Patrick-Healy/replicator/main/install.sh | bash
```

**Or clone and run:**
```bash
git clone https://github.com/Patrick-Healy/replicator.git
cd replicator && ./install.sh
```

The installer auto-detects your AI tools (Gemini, Claude, Codex, Copilot, Cursor) and installs globally.

**Update existing installation:**
```bash
curl -fsSL https://raw.githubusercontent.com/Patrick-Healy/replicator/main/install.sh | bash
# or run /compliance-update in your AI tool
```

---

## Usage

After installation, use these commands in **any research repository**:

| Command | Description |
|---------|-------------|
| `/compliance-check .` | Quick scan for code-level issues |
| `/audit .` | Full DCAS audit (auto-saves to `COMPLIANCE_REPORT.md`) |
| `/compliance-help` | Show available commands and options |
| `/compliance-update` | Check for and install skill updates |

Or just ask naturally:
```
"Check if my repo is DCAS compliant"
"Audit this repository for replication package readiness"
"Is my code ready for AEA submission?"
```

---

## What It Checks

**Code-Level Issues (Automated):**
- Absolute paths that break portability
- Missing random seeds before randomization
- Unpinned dependencies
- Stata-specific issues (version, varabbrev, isid)

**DCAS Compliance (16 Rules):**
- Data availability and documentation
- Code completeness and organization
- README and documentation quality
- License and sharing requirements

**Supported Languages:** Stata, R, Python, MATLAB, Julia

---

## Why Use This?

Preparing replication packages is tedious and error-prone:
- Manually checking for missing files and documentation
- Forgetting to set random seeds or pin dependencies
- Navigating journal-specific requirements

This skill automates the most common checks, saving time and improving submission quality.

---

## Alternative Installation Methods

<details>
<summary>Click to expand manual installation options</summary>

### Install Script Options

```bash
./install.sh           # Install or update from local files
./install.sh --update  # Download latest from GitHub and install
./install.sh --check   # Check for updates without installing
./install.sh --version # Show installed version
```

### Gemini CLI

**Global** (available everywhere):
```bash
mkdir -p ~/.gemini/commands
cp -r /path/to/replicator/.gemini/commands/* ~/.gemini/commands/
```

**Project-level** (this repo only):
```bash
git clone https://github.com/Patrick-Healy/replicator.git
cd replicator
gemini
```

### Claude Code

**Global:**
```bash
mkdir -p ~/.claude/skills
cp -r /path/to/replicator/.github/skills/replication-compliance ~/.claude/skills/
```

**Project-level:**
```bash
mkdir -p .claude/skills
cp -r /path/to/replicator/.github/skills/replication-compliance .claude/skills/
```

### OpenAI Codex

**Using skill-installer:**
```
$skill-installer install replication-compliance from Patrick-Healy/replicator
```

**Manual:**
```bash
mkdir -p ~/.codex/skills
cp -r /path/to/replicator/.github/skills/replication-compliance ~/.codex/skills/
```

### GitHub Copilot

```bash
mkdir -p ~/.copilot/skills
cp -r /path/to/replicator/.github/skills/replication-compliance ~/.copilot/skills/
```

### Cursor

```bash
mkdir -p ~/.cursor/rules
cp /path/to/replicator/.github/skills/replication-compliance/SKILL.md \
   ~/.cursor/rules/replication-compliance.mdc
```

</details>

---

## Agent Compatibility

| Agent | Global Location | Project Location |
|-------|-----------------|------------------|
| **Gemini CLI** | `~/.gemini/commands/` | `.gemini/commands/` |
| **Claude Code** | `~/.claude/skills/` | `.claude/skills/` |
| **OpenAI Codex** | `~/.codex/skills/` | `.codex/skills/` |
| **GitHub Copilot** | `~/.copilot/skills/` | `.github/skills/` |
| **Cursor** | `~/.cursor/rules/` | `.cursor/rules/` |

**Documentation:**
- [Agent Skills Standard](https://agentskills.io/specification)
- [Gemini CLI Commands](https://geminicli.com/docs/cli/custom-commands/)
- [Claude Code Skills](https://code.claude.com/docs/en/skills)
- [OpenAI Codex Skills](https://developers.openai.com/codex/skills/)
- [GitHub Copilot Skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills)

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
.github/skills/replication-compliance/
├── SKILL.md                      # Agent instructions: defines audit workflow
├── scripts/
│   └── check_compliance.py       # Automated checker: fast file/pattern searches
├── references/
│   ├── DCAS_RULES.md             # All 16 DCAS rules explained
│   ├── LANGUAGE_GUIDES.md        # Stata, R, Python, MATLAB, Julia best practices
│   ├── VERSION_CONTROL_WORKFLOWS.md  # Git workflows (CLI + GitHub Desktop)
│   └── GITHUB_MCP_SETUP.md       # MCP server integration for tool access
└── assets/
    └── report_template.md        # Report format template
```

### How the Components Work Together

| Component | Role |
|-----------|------|
| `SKILL.md` | High-level prompt defining the step-by-step audit workflow. The agent reads this to understand what to check and how to report findings. |
| `check_compliance.py` | Python script the agent can run for fast automated checks (file existence, regex searches for seeds, license detection). Optional. |
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

## GitHub PR Review Integration

Set up automatic compliance checking on pull requests with any of these AI tools:

| Platform | Trigger | Setup |
|----------|---------|-------|
| **Claude Code** | `@claude review` | [claude-code-action](https://github.com/anthropics/claude-code-action) |
| **OpenAI Codex** | `@codex review` | [codex-action](https://developers.openai.com/codex/github-action/) or [chatgpt.com/codex](https://chatgpt.com/codex) |
| **Gemini CLI** | `@gemini-cli /review` | [run-gemini-cli](https://github.com/google-github-actions/run-gemini-cli) |
| **GitHub Copilot** | `@copilot review` | Native (via repository rulesets) |

Each tool reads the skill from `.github/skills/replication-compliance/SKILL.md` and checks PRs for:
- Absolute paths that break portability
- Missing random seeds
- Unpinned dependencies
- Documentation gaps

**Full setup guide:** [`references/GITHUB_INTEGRATIONS.md`](.github/skills/replication-compliance/references/GITHUB_INTEGRATIONS.md)

---

## Template Files (Optional)

This repo includes a best-practice project structure from SoDa Labs. **Use of this template is recommended but not required.**

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

### To improve agent compatibility:
- Update bridge files (`.cursorrules`, `.windsurfrules`, etc.)
- Test with the target agent
- Document any agent-specific behavior

---

## Resources

**Standards:**
- [Agent Skills Specification](https://agentskills.io/specification) - The skill format
- [AGENTS.md](https://agents.md/) - Project context standard
- [DCAS v1.0](https://datacodestandard.org) - The compliance standard
- [Model Context Protocol](https://modelcontextprotocol.io/) - Tool integration

**Guides:**
- [AEA Data Editor](https://aeadataeditor.github.io/aea-de-guidance/) - Journal guidelines
- [Julian Reif's Stata Guide](https://julianreif.com/guide/) - Best practices
- [GitHub Blog: Writing a Great AGENTS.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)

**Community:**
- [awesome-agent-skills](https://github.com/skillmatic-ai/awesome-agent-skills) - Skill collection
- [awesome-copilot](https://github.com/github/awesome-copilot) - Copilot resources

---

## License

MIT License - see [LICENSE](LICENSE)
