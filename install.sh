#!/bin/bash
#
# install.sh: Installer for the Replication Compliance Skill
#
# Detects supported AI coding assistants and installs/updates the skill globally.
# Run from the root of the replicator repository.
#
# Usage:
#   ./install.sh           # Install or update
#   ./install.sh --update  # Update from GitHub (auto-downloads latest)
#   ./install.sh --check   # Check for updates without installing
#

set -e

# --- Configuration ---
SKILL_NAME="replication-compliance"
SOURCE_SKILL_DIR=".github/skills/replication-compliance"
REPO_URL="https://github.com/Patrick-Healy/replicator"
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
VERSION="1.2"  # Update this when releasing new versions

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
UPDATED_TOOLS=()

# --- Update Functions ---

check_for_updates() {
    echo_bold "Checking for updates..."

    # Get latest version from GitHub
    LATEST_VERSION=$(curl -s "https://raw.githubusercontent.com/Patrick-Healy/replicator/main/install.sh" | grep "^VERSION=" | cut -d'"' -f2 2>/dev/null || echo "unknown")

    echo "  Current version: $VERSION"
    echo "  Latest version:  $LATEST_VERSION"

    if [ "$LATEST_VERSION" != "unknown" ] && [ "$LATEST_VERSION" != "$VERSION" ]; then
        echo_yellow "  Update available!"
        return 0
    else
        echo_green "  You have the latest version."
        return 1
    fi
}

update_from_github() {
    echo_bold "Updating from GitHub..."

    TEMP_DIR=$(mktemp -d)

    echo "  -> Cloning latest version..."
    git clone --depth 1 "$REPO_URL.git" "$TEMP_DIR/replicator" 2>/dev/null

    if [ ! -d "$TEMP_DIR/replicator" ]; then
        echo_red "  Error: Failed to clone repository"
        rm -rf "$TEMP_DIR"
        exit 1
    fi

    echo "  -> Running installer..."
    cd "$TEMP_DIR/replicator"
    ./install.sh

    echo "  -> Cleaning up..."
    cd /
    rm -rf "$TEMP_DIR"

    echo_green "  Update complete!"
}

# --- Installation Functions ---

install_for_gemini() {
    echo_bold "Checking for Gemini CLI..."

    # Check if gemini command exists or ~/.gemini directory exists
    if ! command -v gemini &> /dev/null && [ ! -d "$HOME/.gemini" ]; then
        echo "  -> Gemini CLI not detected. Skipping."
        return
    fi

    GEMINI_DIR="$HOME/.gemini"
    COMMANDS_DIR="$GEMINI_DIR/commands"
    SKILLS_DIR="$GEMINI_DIR/skills/$SKILL_NAME"

    # Check if already installed
    if [ -d "$SKILLS_DIR" ]; then
        echo "  -> Updating Gemini CLI installation..."
        UPDATED_TOOLS+=("Gemini CLI")
    else
        echo "  -> Installing for Gemini CLI..."
    fi

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
    echo "    Commands: /compliance-check, /audit, /compliance-help, /compliance-update"
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

    CLAUDE_DIR="$HOME/.claude"
    SKILLS_DIR="$CLAUDE_DIR/skills/$SKILL_NAME"

    # Check if already installed
    if [ -d "$SKILLS_DIR" ]; then
        echo "  -> Updating Claude Code installation..."
        UPDATED_TOOLS+=("Claude Code")
    else
        echo "  -> Installing for Claude Code..."
    fi

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

    CODEX_DIR="$HOME/.codex"
    SKILLS_DIR="$CODEX_DIR/skills/$SKILL_NAME"

    # Check if already installed
    if [ -d "$SKILLS_DIR" ]; then
        echo "  -> Updating OpenAI Codex installation..."
        UPDATED_TOOLS+=("OpenAI Codex")
    else
        echo "  -> Installing for OpenAI Codex..."
    fi

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

    CURSOR_DIR="$HOME/.cursor"
    RULES_DIR="$CURSOR_DIR/rules"

    # Check if already installed
    if [ -f "$RULES_DIR/$SKILL_NAME.mdc" ]; then
        echo "  -> Updating Cursor installation..."
        UPDATED_TOOLS+=("Cursor")
    else
        echo "  -> Installing for Cursor..."
    fi

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

    COPILOT_DIR="$HOME/.copilot"
    SKILLS_DIR="$COPILOT_DIR/skills/$SKILL_NAME"

    # Check if already installed
    if [ -d "$SKILLS_DIR" ]; then
        echo "  -> Updating GitHub Copilot installation..."
        UPDATED_TOOLS+=("GitHub Copilot")
    else
        echo "  -> Installing for GitHub Copilot..."
    fi

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
    echo_bold "  Version: $VERSION"
    echo_bold "=========================================="
    echo ""

    # Handle command line arguments
    case "${1:-}" in
        --update)
            check_for_updates || true
            echo ""
            update_from_github
            exit 0
            ;;
        --check)
            check_for_updates
            exit $?
            ;;
        --version)
            echo "Version: $VERSION"
            exit 0
            ;;
        --help|-h)
            echo "Usage: ./install.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  (none)     Install or update from local files"
            echo "  --update   Download latest from GitHub and install"
            echo "  --check    Check for updates without installing"
            echo "  --version  Show version"
            echo "  --help     Show this help"
            exit 0
            ;;
    esac

    # Verify we're in the right directory
    if [ ! -d "$REPO_ROOT/$SOURCE_SKILL_DIR" ]; then
        echo_red "Error: Cannot find skill directory at $SOURCE_SKILL_DIR"
        echo_red "Please run this script from the replicator repository root."
        echo ""
        echo "To update from GitHub instead, run:"
        echo "  curl -fsSL $REPO_URL/raw/main/install.sh | bash -s -- --update"
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
        if [ ${#UPDATED_TOOLS[@]} -gt 0 ]; then
            echo_green "Updated: ${UPDATED_TOOLS[*]}"
        fi
        echo_green "Installed for: ${INSTALLED_TOOLS[*]}"
        echo ""
        echo "Quick Start:"
        echo "  1. Open your AI tool in any research repository"
        echo "  2. Run: /compliance-check .   (quick scan)"
        echo "  3. Run: /audit .              (full report)"
        echo ""
        echo "For help: /compliance-help"
        echo "To update: /compliance-update (or ./install.sh --update)"
        echo ""
        echo_yellow "Tip: Restart your AI tool to load the new commands."
    fi
    echo ""
}

main "$@"
