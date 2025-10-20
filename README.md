# personal-os

My personal operating system configurations and productivity tools for software development.

## Overview

This repository serves as the single source of truth for my development environment, containing:
- **Dotfiles** (`.zshrc`, etc.)
- **Claude Code slash commands**
- **Utility scripts**

All configurations are stored in this repository and symlinked to their appropriate system locations using the `sync.sh` script.

## Quick Start

```bash
# Clone this repository
git clone https://github.com/yourusername/personal-os.git
cd personal-os

# Run the sync script to create all symlinks
./sync.sh
```

This will:
1. Back up any existing configurations
2. Create symlinks from your system to this repository
3. Verify all symlinks are working correctly

## Directory Structure

```
personal-os/
├── dotfiles/          # Configuration files (source of truth)
│   └── .zshrc         # Zsh configuration
├── claude-commands/   # Claude Code slash commands
│   ├── commit.md
│   ├── create-command.md
│   ├── deep-research-query.md
│   └── summarize.md
├── scripts/           # Utility scripts
│   └── README.md
└── sync.sh           # Sync script to manage symlinks
```

## Components

### dotfiles/

Contains configuration files that are symlinked to your home directory:
- `.zshrc` → `~/.zshrc`

Add any other dotfiles here (`.gitconfig`, `.vimrc`, etc.) and update `sync.sh` to include them.

### claude-commands/

Custom slash commands for Claude Code. The entire directory is symlinked to `~/.claude/commands/`.

**Available Commands:**
- `/commit` - Stage files and create conventional commits
- `/create-command` - Create new custom slash commands with best practices
- `/deep-research-query` - Formulate detailed research queries
- `/summarize` - Summarize conversations with customizable focus

**Adding New Commands:**
1. Create a `.md` file in `claude-commands/`
2. Use `$ARGUMENTS` to accept parameters
3. Run `./sync.sh` to update symlinks (or they'll be available immediately if already synced)

Example command:
```markdown
# my-command.md
Do something with: $ARGUMENTS
```

### scripts/

Directory for utility scripts and automation tools. Add your custom scripts here.

### sync.sh

The synchronization script that:
- Creates symlinks from system locations to this repository
- Backs up existing configurations before making changes
- Verifies all symlinks are correctly set up
- Works headlessly (no user prompts)

**Usage:**
```bash
./sync.sh
```

**What it does:**
1. Backs up existing files to `~/.personal-os-backups/[timestamp]/`
2. Creates symlinks:
   - `~/.zshrc` → `dotfiles/.zshrc`
   - `~/.claude/commands/` → `claude-commands/`
3. Verifies all symlinks are working

## Workflow

1. **Make changes in this repository** - All files should be edited here, not in their system locations
2. **Commit and push changes** - Keep your configurations version controlled
3. **Pull on other machines** - Get your latest configurations on any machine
4. **Run `sync.sh`** - Ensure symlinks are set up correctly

## Backups

The `sync.sh` script automatically creates backups before making any changes. Backups are stored in:
```
~/.personal-os-backups/[timestamp]/
```

Each backup is timestamped, so you can always recover previous configurations if needed.

## Contributing to Your Own Setup

Since this is a personal repository, feel free to:
1. Add new dotfiles to `dotfiles/`
2. Create new Claude commands in `claude-commands/`
3. Add utility scripts to `scripts/`
4. Update `sync.sh` to handle new file types

Remember: The repository is always the source of truth. System locations only contain symlinks pointing back here.