---
name: replication-compliance
description: Audit research repositories against the Data and Code Availability Standard (DCAS). Use when checking replication package compliance, preparing journal submissions, reviewing code organization for reproducibility, or validating that a project meets AEA/economics journal standards.
license: MIT
metadata:
  author: sodalabsio
  version: "1.0"
  standard: DCAS v1.0
compatibility: Requires file system access. Works with Stata, R, and Python projects.
---

# Replication Compliance Checker

Audit research repositories against the [Data and Code Availability Standard (DCAS)](https://datacodestandard.org) to ensure reproducibility and journal compliance.

## When to Use This Skill

Activate this skill when the user:
- Asks to check replication package compliance
- Wants to prepare for journal submission (AEA, QJE, REStat, etc.)
- Needs to audit code organization for reproducibility
- Asks "is my repo ready for submission?"
- Mentions DCAS, AEA Data Editor, or replication standards
- Wants to compare their project against best practices

## How to Audit a Repository

### Step 1: Identify Repository Structure

First, understand the project layout:

```bash
# Look for common structures
ls -la
ls -la code/ data/ paper/ 2>/dev/null || ls -la scripts/ 2>/dev/null
```

Common patterns:
- **SoDa Replicator**: `code/`, `data/`, `paper/`
- **Reif-style**: `analysis/data/`, `analysis/scripts/`, `analysis/results/`
- **Flat**: All files in root with `run.do` or `main.R`

### Step 2: Run Compliance Checks

Check each DCAS category systematically:

#### Data Availability [DCAS Rules 1-6]

| Rule | Check | How to Verify |
|------|-------|---------------|
| 1 | Data Availability Statement | Search README for "Data Availability" or "Data Access" section |
| 2 | Raw data | Check `data/raw/` exists with files or documentation |
| 3 | Analysis data | Check `data/analysis/` or equivalent exists |
| 4 | Data format | Verify standard formats: .csv, .dta, .rds, .parquet, .xlsx |
| 5 | Metadata | Look for codebook, variable descriptions, or data documentation |
| 6 | Citations | Check README references all data sources |

```bash
# Check data structure
find . -type d -name "raw" -o -name "data" 2>/dev/null
find . -name "codebook*" -o -name "*_codebook*" -o -name "variables*" 2>/dev/null
grep -ri "data availability" README* 2>/dev/null
```

#### Code [DCAS Rules 7-9]

| Rule | Check | How to Verify |
|------|-------|---------------|
| 7 | Data transformation | Scripts that process raw → analysis data exist |
| 8 | Analysis programs | Scripts that produce results exist |
| 9 | Source format | Code in readable source format (not compiled) |

```bash
# Find master scripts
find . -name "run.do" -o -name "run.R" -o -name "main.py" -o -name "master.do" 2>/dev/null

# Check for analysis code
find . -type d -name "analysis" -o -name "scripts" 2>/dev/null
find . -name "*.do" -o -name "*.R" -o -name "*.py" 2>/dev/null | head -20
```

#### Supporting Materials [DCAS Rules 10-12]

| Rule | Check | How to Verify |
|------|-------|---------------|
| 10 | Instruments | Survey/experiment docs if applicable |
| 11 | Ethics | IRB approval documented if applicable |
| 12 | Pre-registration | Registry link if applicable |

```bash
# Check for supporting documents
find . -type d -name "documents" -o -name "docs" 2>/dev/null
grep -ri "IRB\|ethics\|pre-registration\|registered" README* 2>/dev/null
```

#### Documentation [DCAS Rule 13]

Must include:
- [ ] README with Data Availability Statement
- [ ] Software requirements with versions
- [ ] Hardware requirements (memory, time)
- [ ] Step-by-step replication instructions

```bash
# Check README completeness
cat README.md 2>/dev/null | head -100

# Look for requirements
find . -name "requirements.txt" -o -name "renv.lock" -o -name "*.Rproj" 2>/dev/null
```

#### Sharing [DCAS Rules 14-16]

| Rule | Check | How to Verify |
|------|-------|---------------|
| 14 | Location | Archive/DOI documented |
| 15 | License | LICENSE file exists |
| 16 | Omissions | Missing data explained |

```bash
# Check license
cat LICENSE 2>/dev/null | head -5
ls LICENSE* 2>/dev/null
```

### Step 3: Language-Specific Checks

#### Stata Projects

```stata
* Required in master script:
version 18          // Version statement
set varabbrev off   // Prevent abbreviation errors
set seed 12345      // Reproducible randomization
```

Check for:
- [ ] `version` statement at top of master script
- [ ] `set varabbrev off`
- [ ] `set seed` before any randomization
- [ ] Forward slashes in paths (cross-platform)
- [ ] Packages bundled in `libraries/stata/` OR documented

#### R Projects

Check for:
- [ ] `renv.lock` file (package versions)
- [ ] `set.seed()` before randomization
- [ ] Session info logged
- [ ] No hardcoded paths

```r
# Required for reproducibility:
set.seed(12345)
renv::snapshot()  # Lock package versions
sessionInfo()     # Document environment
```

#### Python Projects

Check for:
- [ ] `requirements.txt` with pinned versions (`package==1.2.3`)
- [ ] Random seeds: `random.seed()`, `np.random.seed()`
- [ ] Virtual environment documented
- [ ] No hardcoded paths

#### MATLAB Projects

Check for:
- [ ] All custom `.m` files included in repository
- [ ] Toolbox dependencies documented in README
- [ ] `startup.m` configures paths if needed
- [ ] Random seed: `rng(12345)` for reproducibility

```matlab
% Required for reproducibility:
rng(12345);  % Set random seed
addpath(genpath('functions'));  % Add local functions to path
```

#### Julia Projects

Check for:
- [ ] `Project.toml` and `Manifest.toml` files
- [ ] Random seed: `Random.seed!(12345)`
- [ ] No hardcoded paths

### Step 4: Generate Compliance Report

Structure the report as follows:

```markdown
# Replication Compliance Report

**Repository:** [name]
**Date:** [YYYY-MM-DD]
**Standard:** DCAS v1.0

## Summary

| Category | Score | Status |
|----------|-------|--------|
| Data Availability (1-6) | X/6 | ✅/⚠️/❌ |
| Code (7-9) | X/3 | ✅/⚠️/❌ |
| Supporting Materials (10-12) | X/3 | ✅/⚠️/❌ |
| Documentation (13) | X/5 | ✅/⚠️/❌ |
| Sharing (14-16) | X/3 | ✅/⚠️/❌ |
| **Overall** | **X/20** | **X%** |

## Passing Checks ✅
[List items that pass]

## Warnings ⚠️
[List items partially complete]

## Missing ❌
[List items that fail]

## Priority Recommendations
1. [Most critical fix]
2. [Second priority]
3. [Third priority]
```

## Common Issues and Fixes

### Issue: No Data Availability Statement

**Fix:** Add to README:

```markdown
## Data Availability

The data used in this study are available as follows:

| Source | Access | Location |
|--------|--------|----------|
| [Name] | Public | `data/raw/[source]/` |
| [Name] | Restricted | Apply at [URL] |
```

### Issue: No Master Script

**Fix:** Create `run.do` (Stata) or `run.R` (R) that:
1. Sets up environment
2. Runs all scripts in order
3. Generates all outputs

### Issue: Packages Not Documented

**Stata Fix:** Create `_install_stata_packages.do`:
```stata
ssc install reghdfe
ssc install estout
```

**R Fix:** Initialize renv:
```r
renv::init()
renv::snapshot()
```

### Issue: No License

**Fix:** Add `LICENSE` file. Recommended: [AEA mixed license](https://github.com/AEADataEditor/aea-de-guidance/blob/master/template-LICENSE.md)

### Issue: Hardcoded Paths

**Fix:** Replace absolute paths with relative paths or globals:
```stata
* BAD
use "C:/Users/name/project/data/file.dta"

* GOOD
use "../data/file.dta"
* OR
use "$DATA/file.dta"
```

## Special Cases

### Confidential/Restricted Data

When data cannot be shared publicly:

1. **Check for Data Availability Statement** explaining:
   - Why data is restricted (legal, privacy, proprietary)
   - How to apply for access
   - Contact information for data provider
   - Estimated time/cost for access

2. **Verify synthetic/simulated data** is provided for code testing

3. **Suggest this template:**

```markdown
## Data Availability

The analysis uses confidential administrative data from [Agency].
These data are available to researchers who:
1. Apply at [URL]
2. Complete IRB approval
3. Access data at [Secure Location]

Expected processing time: 3-6 months.
Contact: data-access@agency.gov

**For code testing:** We provide simulated data in `data/simulated/`
that allows the code to run and demonstrates the analysis structure.
```

### Large Data Files

Check for proper large file handling:

```bash
# Check for git-lfs
cat .gitattributes 2>/dev/null
git lfs ls-files 2>/dev/null

# Check for large files that should use LFS
find . -type f -size +50M -not -path "./.git/*" 2>/dev/null
```

If large files found without LFS:
> "I found large files (>50MB) not using git-lfs. Large files slow down git operations and may exceed GitHub limits. Consider using git-lfs or storing data externally."

### External Data Repositories

When data is hosted externally (ICPSR, Dataverse, Zenodo):

1. **Verify README documents:**
   - Repository name and DOI
   - Exact files to download
   - Where to place files locally
   - Any access requirements

2. **Check for download scripts:**

```bash
# Look for automated download scripts
find . -name "*download*" -o -name "*fetch*" 2>/dev/null
```

### Dynamic Documents (R Markdown, Jupyter)

```bash
# Find dynamic documents
find . -name "*.Rmd" -o -name "*.qmd" -o -name "*.ipynb" 2>/dev/null
```

For these files, verify:
- [ ] All code chunks can execute independently
- [ ] Output is reproducible (seeds set)
- [ ] Dependencies documented

## Interactive Repair Suggestions

When issues are found, offer to fix them:

### Missing LICENSE

Instead of: "FAIL: No license found."

Say:
> "I could not find a LICENSE file. For replication packages, the AEA recommends a dual license (MIT for code, CC-BY for data). Would you like me to create a LICENSE file with the AEA template?"

Then if user agrees:
```bash
# Agent can create this file
curl -o LICENSE https://raw.githubusercontent.com/AEADataEditor/aea-de-guidance/master/template-LICENSE.md
```

### Missing Data Availability Statement

Instead of: "FAIL: No Data Availability Statement."

Say:
> "Your README doesn't have a Data Availability Statement. I can see data files in `data/raw/`. Would you like me to add a template section to your README that you can fill in?"

### Unpinned Python Dependencies

Instead of: "WARNING: requirements.txt has unpinned versions."

Say:
> "I see `pandas` in requirements.txt without a version pin. This can cause reproducibility issues. I can update it to `pandas==2.1.4` (your current version). Should I pin all package versions?"

## Configuration File (Optional)

Users can create `.replication-check.yml` to customize checks:

```yaml
# .replication-check.yml
version: 1

# Disable specific rules
ignore:
  - rule-10  # No survey instruments (secondary data only)
  - rule-11  # No IRB needed (public data)
  - rule-12  # Not pre-registered

# Specify primary language
language: stata

# Custom paths
paths:
  data: ./data
  code: ./analysis
  output: ./results

# Large file threshold (MB)
large_file_threshold: 100

# Confidential data mode
confidential_data: true
```

When this file exists, adjust checks accordingly.

## Quick Compliance Checklist

For rapid assessment, verify these essentials:

- [ ] README exists with Data Availability Statement
- [ ] LICENSE file exists
- [ ] Master script (`run.do`/`run.R`) exists
- [ ] All data sources documented
- [ ] Software versions specified
- [ ] Replication instructions provided

## Reference Files

For detailed guidance, see:
- [references/DCAS_RULES.md](references/DCAS_RULES.md) - Complete DCAS rules
- [references/CHECKLIST.md](references/CHECKLIST.md) - Detailed checklist
- [references/LANGUAGE_GUIDES.md](references/LANGUAGE_GUIDES.md) - Stata/R/Python specifics
- [references/GITHUB_MCP_SETUP.md](references/GITHUB_MCP_SETUP.md) - GitHub MCP server setup
- [references/VERSION_CONTROL_WORKFLOWS.md](references/VERSION_CONTROL_WORKFLOWS.md) - Git workflows

---

## GitHub Integration & Version Control

### GitHub MCP Server

For enhanced GitHub integration, users can set up the [GitHub MCP Server](https://github.com/github/github-mcp-server). See [references/GITHUB_MCP_SETUP.md](references/GITHUB_MCP_SETUP.md) for complete setup instructions.

### Command Safety Classification

**CRITICAL: The agent must follow these safety rules for all git/GitHub operations.**

#### 🟢 SAFE - Agent Can Execute Freely

```bash
# Read-only operations
git status
git log --oneline -10
git diff
git branch -a
gh repo view
gh issue list
gh pr list
gh pr view <number>
```

#### 🟡 MODERATE - Agent Should Confirm Before Executing

```bash
# These make changes but are generally reversible
git add <specific-file>
git commit -m "message"
git checkout -b new-branch
git stash
gh issue create --title "..." --body "..."
gh pr create --title "..." --body "..."
```

Before executing moderate commands, say:
> "I'm about to [action]. This will [effect]. Should I proceed?"

#### 🔴 DANGEROUS - Provide Command, User Executes Manually

**NEVER execute these commands. Always provide them for the user to run.**

```bash
# Pushing to main/master
git push origin main
# Say: "To push these changes, run: git push origin main"

# Merging (local or PR)
git merge <branch>
gh pr merge <number>
# Say: "To merge this PR, run: gh pr merge <number> --merge"

# Rebasing (rewrites history)
git rebase main
git rebase -i HEAD~3
# Say: "Rebasing rewrites history. To proceed, run: git rebase main"

# Deleting branches
git branch -d <branch>          # Safe: only if merged
git branch -D <branch>          # Force delete - can lose work
git push origin --delete <branch>
# Say: "To delete this branch, run: git branch -d <branch>"

# Closing issues/PRs
gh issue close <number>
gh pr close <number>
# Say: "To close this issue, run: gh issue close <number>"

# Tagging releases
git tag -a v1.0 -m "message"
git push origin v1.0
# Say: "To create this release tag, run: git tag -a v1.0 -m '...'"
```

#### ⛔ FORBIDDEN - Never Execute or Suggest

```bash
# Force push - can destroy collaborators' work
git push --force
git push -f
git push --force-with-lease  # Still dangerous

# Hard reset - loses uncommitted work
git reset --hard
git reset --hard HEAD~N
git checkout -- .            # Discards all changes

# Clean - removes untracked files permanently
git clean -fd
git clean -fdx               # Also removes ignored files

# Repository deletion
gh repo delete

# Modifying permissions/settings
gh api repos/{owner}/{repo}/collaborators
gh repo edit --visibility

# Rewriting published history
git filter-branch
git rebase on pushed commits
```

If user requests forbidden commands, explain the risk:
> "Force pushing can overwrite your collaborators' work and is generally not recommended. If you need to update a branch, consider `git revert` instead, which is safer."

### Version Control for Replication Packages

#### Check Version Control Status

```bash
# Safe to run
git status
git log --oneline -5
git remote -v
```

#### DCAS Rule 14: Archive Location

Help users prepare for archiving:

```bash
# Safe: Create tag for submission version
# SAY: "To tag this version for submission, run:"
git tag -a v1.0-submission -m "Version submitted to [Journal]"
git push origin v1.0-submission

# Safe: View existing releases
gh release list

# PROVIDE (don't execute): Create release
# SAY: "To create a GitHub release, run:"
gh release create v1.0 --title "Replication Package v1.0" --notes "..."
```

#### DCAS Rule 15: License Check

```bash
# Safe: Check for license
cat LICENSE 2>/dev/null || echo "No LICENSE file found"

# If missing, provide template:
# SAY: "You need a LICENSE file. Download the AEA template from:
# https://github.com/AEADataEditor/aea-de-guidance/blob/master/template-LICENSE.md"
```

### GitHub Workflow Recommendations

When suggesting git operations, always:

1. **Explain what the command does**
2. **State the risk level**
3. **For dangerous commands, provide the command but don't execute**

Example response for PR workflow:

> I've reviewed the changes and they look ready for submission. Here's what to do:
>
> 1. **Create a PR** (I can do this for you):
>    ```bash
>    gh pr create --title "Add robustness checks" --body "..."
>    ```
>
> 2. **After review, merge the PR** (you must run this manually):
>    ```bash
>    gh pr merge <number> --merge
>    ```
>
> 3. **Tag the release** (you must run this manually):
>    ```bash
>    git tag -a v1.0 -m "Submission version"
>    git push origin v1.0
>    ```
>
> Should I create the PR?

### Setting Up GitHub MCP (User Guide)

If the user asks about GitHub MCP setup, provide this summary:

**Option A: Docker (Recommended - Safest)**

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run", "-i", "--rm",
        "-e", "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server",
        "--read-only"
      ]
    }
  }
}
```

**Option B: Non-Docker (When Docker Unavailable)**

⚠️ **Risk Warning:** Non-Docker runs with your user permissions without container isolation. Only use if Docker is not available.

```json
{
  "mcpServers": {
    "github": {
      "command": "${HOME}/.local/bin/github-mcp-server",
      "args": ["stdio", "--read-only"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

Build instructions:
```bash
git clone https://github.com/github/github-mcp-server.git
cd github-mcp-server
go build -o ~/.local/bin/github-mcp-server ./cmd/github-mcp-server
```

**Option C: No MCP - Use gh CLI Directly**

For simple operations, the `gh` CLI works without MCP:

```bash
gh auth login
gh repo view
gh pr list
gh issue create --title "..." --body "..."
```

**Option D: GitHub Desktop (GUI - No Command Line)**

For users who prefer visual interfaces:

1. Download: https://desktop.github.com/
2. Sign in with GitHub account
3. Clone repositories visually
4. Commit, push, pull with buttons

**GitHub Desktop equivalents:**
| Command | GitHub Desktop |
|---------|----------------|
| `git status` | View Changes panel |
| `git add` | Check file boxes |
| `git commit` | Write message → Commit |
| `git push` | Push origin button |
| `git pull` | Fetch → Pull origin |
| `gh pr create` | "Create Pull Request" button |

⚠️ **Limitations:** Cannot create tags, limited merge tools. See [VERSION_CONTROL_WORKFLOWS.md](references/VERSION_CONTROL_WORKFLOWS.md) for details.

**Security Checklist (All Options):**
- [ ] Use fine-grained Personal Access Token (not classic)
- [ ] Grant minimum necessary permissions
- [ ] Set token expiration (90 days recommended)
- [ ] Store token in environment variable, not config file
- [ ] Set file permissions: `chmod 600` on token files
- [ ] Add token files to .gitignore
- [ ] Always use `--read-only` mode unless writes needed

See [references/GITHUB_MCP_SETUP.md](references/GITHUB_MCP_SETUP.md) for complete instructions including risk comparison table.
