#!/bin/bash

# sync.sh - Synchronize dotfiles, scripts, and Claude commands
# This script creates symlinks from system locations to this repository
# The repository is the source of truth - all files live here

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.personal-os-backups/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Backup a file or directory if it exists
backup_if_exists() {
    local target="$1"
    local backup_name="${2:-$(basename "$target")}"

    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        local backup_path="$BACKUP_DIR/$backup_name"

        # Copy the actual content (following symlinks with -L)
        cp -RL "$target" "$backup_path" 2>/dev/null || true

        log_info "Backed up: $target"
        return 0
    fi
    return 1
}

# Create a symlink with verification
create_symlink() {
    local source="$1"  # File or directory in the repo
    local target="$2"  # Where the symlink should be created
    local description="$3"

    # Verify source exists
    if [ ! -e "$source" ]; then
        log_error "Source not found: $source"
        return 1
    fi

    # Create parent directory if it doesn't exist
    local target_dir="$(dirname "$target")"
    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
        log_info "Created parent directory: $target_dir"
    fi

    # Backup existing file/directory/symlink
    backup_if_exists "$target"

    # Remove existing target (file, directory, or symlink)
    if [ -e "$target" ] || [ -L "$target" ]; then
        rm -rf "$target"
    fi

    # Create symlink
    ln -s "$source" "$target"

    # Verify symlink
    if [ -L "$target" ] && [ -e "$target" ]; then
        log_success "$description"
        return 0
    else
        log_error "Failed to create symlink: $target → $source"
        return 1
    fi
}

# Main sync logic
main() {
    log_info "Starting sync from repository: $SCRIPT_DIR"
    log_info "Repository is the source of truth - creating symlinks to it"
    echo ""

    local overall_status=0

    # Sync dotfiles
    log_info "Syncing dotfiles..."
    if [ -f "$SCRIPT_DIR/dotfiles/.zshrc" ]; then
        create_symlink "$SCRIPT_DIR/dotfiles/.zshrc" "$HOME/.zshrc" "Linked: ~/.zshrc → repo" || overall_status=1
    else
        log_warning "Dotfile not found: dotfiles/.zshrc"
        overall_status=1
    fi
    echo ""

    # Sync Claude commands directory
    log_info "Syncing Claude commands..."
    if [ -d "$SCRIPT_DIR/claude-commands" ]; then
        create_symlink "$SCRIPT_DIR/claude-commands" "$HOME/.claude/commands" "Linked: ~/.claude/commands → repo" || overall_status=1
    else
        log_warning "Directory not found: claude-commands"
        overall_status=1
    fi
    echo ""

    # Verify everything is working
    log_info "Verifying symlinks..."
    local verify_failed=0

    # Check .zshrc
    if [ -L "$HOME/.zshrc" ]; then
        local zshrc_target=$(readlink "$HOME/.zshrc")
        if [[ "$zshrc_target" == "$SCRIPT_DIR/dotfiles/.zshrc" ]] && [ -e "$HOME/.zshrc" ]; then
            log_success "~/.zshrc correctly linked"
        else
            log_error "~/.zshrc symlink is broken or points to wrong location"
            log_error "  Target: $zshrc_target"
            verify_failed=1
        fi
    else
        log_error "~/.zshrc is not a symlink"
        verify_failed=1
    fi

    # Check Claude commands directory
    if [ -L "$HOME/.claude/commands" ]; then
        local cmd_target=$(readlink "$HOME/.claude/commands")
        if [[ "$cmd_target" == "$SCRIPT_DIR/claude-commands" ]] && [ -e "$HOME/.claude/commands" ]; then
            # Count files in the linked directory (don't use -type f since it's a symlink)
            local file_count=$(ls "$HOME/.claude/commands"/*.md 2>/dev/null | wc -l | tr -d ' ')
            log_success "~/.claude/commands correctly linked ($file_count command files accessible)"
        else
            log_error "~/.claude/commands symlink is broken or points to wrong location"
            log_error "  Target: $cmd_target"
            verify_failed=1
        fi
    else
        log_error "~/.claude/commands is not a symlink"
        verify_failed=1
    fi

    echo ""

    # Summary
    if [ $overall_status -eq 0 ] && [ $verify_failed -eq 0 ]; then
        log_success "All syncs completed and verified successfully!"
        echo ""
        log_info "Your dotfiles and commands are now synced with the repository."
        log_info "Any changes made to files in the repo will be immediately reflected in the system."
    else
        log_warning "Sync completed with some warnings or errors"
        echo ""
        log_info "Please check the errors above and ensure:"
        log_info "  - The repository contains the expected files"
        log_info "  - You have write permissions to create symlinks"
    fi

    if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR)" ]; then
        echo ""
        log_info "Backups saved to: $BACKUP_DIR"
    fi

    exit $overall_status
}

# Run main function
main