# personal-os

My personal operating system configurations and productivity tools for software development.

## Overview

This repository contains my personal development environment setup, including Claude Code configurations, custom slash commands, and other productivity tools that help streamline my workflow as a software engineer and entrepreneur.

## claude-commands/

Custom slash commands for Claude Code that enhance my development workflow. These commands are symlinked to `~/.claude/commands` for immediate availability.

### Available Commands

- `/commit` - Stage files modified in the current Claude session and create a conventional commit message
  - Usage: `/commit` or `/commit "focus on performance improvements"`

### Adding New Commands

Create `.md` files in the `claude-commands/` directory. Use `$ARGUMENTS` to accept parameters:

```markdown
# My Custom Command
Do something with: $ARGUMENTS
```

Then use: `/my-custom-command "some input"`

### Syncing

The `claude-commands/` directory is symlinked to `~/.claude/commands`, so changes here automatically sync to your local Claude Code setup.
