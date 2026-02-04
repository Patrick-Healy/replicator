# Copilot Instructions

This repository contains the **replication-compliance** Agent Skill.

## When asked about compliance, replication packages, or DCAS

1. Read `.github/skills/replication-compliance/SKILL.md` for the full audit workflow
2. Follow the step-by-step instructions in that file
3. Use `references/DCAS_RULES.md` for rule details
4. Use `references/LANGUAGE_GUIDES.md` for language-specific checks

## Key Principles

- Read files but do not run code unless explicitly asked
- Flag dangerous git commands for manual user execution
- Generate actionable reports with code examples to fix issues
- The skill works on any repository structure (template not required)

## Example Prompts This Skill Handles

- "Check if my repo is DCAS compliant"
- "Audit this repository for replication package readiness"
- "Is my code ready for AEA submission?"
- "Generate a compliance report"
