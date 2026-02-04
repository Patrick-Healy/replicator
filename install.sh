#!/bin/bash
#
# install.sh: Installer for the Replication Compliance Skill
#
# Detects supported AI coding assistants and installs the skill globally.
# Run from the root of the replicator repository.
#

set -e

# --- Configuration ---
SKILL_NAME="replication-compliance"
SOURCE_SKILL_DIR=".github/skills/replication-compliance"
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD='\033[1m'
NC='\033[0m' # No Color

echo_green() { echo -e "${GREEN}$1${NC}"; }
echo_red() { echo -e "${RED}$1${NC}"; }
echo_yellow() { echo -e "${YELLOW}$1${NC}"; }
echo_bold() { echo -e "${BOLD}$1${NC}"; }

# Track what was installed
INSTALLED_TOOLS=()

# --- Installation Functions ---

install_for_gemini() {
    echo_bold "Checking for Gemini CLI..."

    # Check if gemini command exists or ~/.gemini directory exists
    if ! command -v gemini &> /dev/null && [ ! -d "$HOME/.gemini" ]; then
        echo "  -> Gemini CLI not detected. Skipping."
        return
    fi

    echo "  -> Installing for Gemini CLI..."

    GEMINI_DIR="$HOME/.gemini"
    COMMANDS_DIR="$GEMINI_DIR/commands"
    SKILLS_DIR="$GEMINI_DIR/skills/$SKILL_NAME"

    # Create directories
    mkdir -p "$COMMANDS_DIR"
    mkdir -p "$SKILLS_DIR"

    # Copy skill files
    cp -R "$REPO_ROOT/$SOURCE_SKILL_DIR/"* "$SKILLS_DIR/"

    # Copy and update command files with correct paths
    for toml_file in "$REPO_ROOT/.gemini/commands/"*.toml; do
        if [ -f "$toml_file" ]; then
            filename=$(basename "$toml_file")
            # Replace relative path with absolute path in the copied file
            sed "s|$SOURCE_SKILL_DIR|$SKILLS_DIR|g" "$toml_file" > "$COMMANDS_DIR/$filename"
        fi
    done

    # Copy global context file
    if [ -f "$REPO_ROOT/GEMINI.md" ]; then
        sed "s|$SOURCE_SKILL_DIR|$SKILLS_DIR|g" "$REPO_ROOT/GEMINI.md" > "$GEMINI_DIR/GEMINI.md"
    fi

    echo_green "  ✓ Gemini CLI installed"
    echo "    Commands: /compliance-check, /audit, /compliance-help"
    echo "    Location: $SKILLS_DIR"
    INSTALLED_TOOLS+=("Gemini CLI")
}

install_for_claude() {
    echo_bold "Checking for Claude Code..."

    # Check if claude command exists or ~/.claude directory exists
    if ! command -v claude &> /dev/null && [ ! -d "$HOME/.claude" ]; then
        echo "  -> Claude Code not detected. Skipping."
        return
    fi

    echo "  -> Installing for Claude Code..."

    CLAUDE_DIR="$HOME/.claude"
    SKILLS_DIR="$CLAUDE_DIR/skills/$SKILL_NAME"

    # Create directories
    mkdir -p "$SKILLS_DIR"

    # Copy skill files
    cp -R "$REPO_ROOT/$SOURCE_SKILL_DIR/"* "$SKILLS_DIR/"

    echo_green "  ✓ Claude Code installed"
    echo "    Skill: /$SKILL_NAME"
    echo "    Location: $SKILLS_DIR"
    INSTALLED_TOOLS+=("Claude Code")
}

install_for_codex() {
    echo_bold "Checking for OpenAI Codex..."

    # Check if codex command exists or ~/.codex directory exists
    if ! command -v codex &> /dev/null && [ ! -d "$HOME/.codex" ]; then
        echo "  -> OpenAI Codex not detected. Skipping."
        return
    fi

    echo "  -> Installing for OpenAI Codex..."

    CODEX_DIR="$HOME/.codex"
    SKILLS_DIR="$CODEX_DIR/skills/$SKILL_NAME"

    # Create directories
    mkdir -p "$SKILLS_DIR"

    # Copy skill files
    cp -R "$REPO_ROOT/$SOURCE_SKILL_DIR/"* "$SKILLS_DIR/"

    echo_green "  ✓ OpenAI Codex installed"
    echo "    Skill: \$$SKILL_NAME"
    echo "    Location: $SKILLS_DIR"
    INSTALLED_TOOLS+=("OpenAI Codex")
}

install_for_cursor() {
    echo_bold "Checking for Cursor..."

    # Check if ~/.cursor directory exists
    if [ ! -d "$HOME/.cursor" ]; then
        echo "  -> Cursor not detected. Skipping."
        return
    fi

    echo "  -> Installing for Cursor..."

    CURSOR_DIR="$HOME/.cursor"
    RULES_DIR="$CURSOR_DIR/rules"

    # Create directories
    mkdir -p "$RULES_DIR"

    # Copy rule file (convert SKILL.md to .mdc format)
    cp "$REPO_ROOT/$SOURCE_SKILL_DIR/SKILL.md" "$RULES_DIR/$SKILL_NAME.mdc"

    echo_green "  ✓ Cursor installed"
    echo "    Rule: @$SKILL_NAME"
    echo "    Location: $RULES_DIR/$SKILL_NAME.mdc"
    INSTALLED_TOOLS+=("Cursor")
}

install_for_copilot() {
    echo_bold "Checking for GitHub Copilot..."

    # Check if ~/.copilot directory exists
    if [ ! -d "$HOME/.copilot" ]; then
        echo "  -> GitHub Copilot user directory not detected. Skipping."
        return
    fi

    echo "  -> Installing for GitHub Copilot..."

    COPILOT_DIR="$HOME/.copilot"
    SKILLS_DIR="$COPILOT_DIR/skills/$SKILL_NAME"

    # Create directories
    mkdir -p "$SKILLS_DIR"

    # Copy skill files
    cp -R "$REPO_ROOT/$SOURCE_SKILL_DIR/"* "$SKILLS_DIR/"

    echo_green "  ✓ GitHub Copilot installed"
    echo "    Location: $SKILLS_DIR"
    INSTALLED_TOOLS+=("GitHub Copilot")
}

# --- Main ---

main() {
    echo ""
    echo_bold "=========================================="
    echo_bold "  Replication Compliance Skill Installer"
    echo_bold "=========================================="
    echo ""

    # Verify we're in the right directory
    if [ ! -d "$REPO_ROOT/$SOURCE_SKILL_DIR" ]; then
        echo_red "Error: Cannot find skill directory at $SOURCE_SKILL_DIR"
        echo_red "Please run this script from the replicator repository root."
        exit 1
    fi

    echo "Detecting installed AI tools..."
    echo ""

    # Run installers
    install_for_gemini
    echo ""
    install_for_claude
    echo ""
    install_for_codex
    echo ""
    install_for_cursor
    echo ""
    install_for_copilot
    echo ""

    # Summary
    echo_bold "=========================================="
    echo_bold "  Installation Complete"
    echo_bold "=========================================="
    echo ""

    if [ ${#INSTALLED_TOOLS[@]} -eq 0 ]; then
        echo_yellow "No supported AI tools were detected."
        echo ""
        echo "Supported tools:"
        echo "  - Gemini CLI (https://github.com/google-gemini/gemini-cli)"
        echo "  - Claude Code (https://claude.ai/code)"
        echo "  - OpenAI Codex (https://openai.com/codex)"
        echo "  - Cursor (https://cursor.com)"
        echo "  - GitHub Copilot (https://copilot.github.com)"
        echo ""
        echo "Install one of these tools, then run this script again."
    else
        echo_green "Installed for: ${INSTALLED_TOOLS[*]}"
        echo ""
        echo "Quick Start:"
        echo "  1. Open your AI tool in any research repository"
        echo "  2. Run: /compliance-check .   (quick scan)"
        echo "  3. Run: /audit .              (full report)"
        echo ""
        echo "For help: /compliance-help"
        echo ""
        echo_yellow "Tip: Restart your AI tool to load the new commands."
    fi
    echo ""
}

main "$@"
