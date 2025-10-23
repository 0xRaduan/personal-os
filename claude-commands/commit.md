# Commit changes from current session

Review all files modified in the current Claude session, stage them, and create a commit with a message following conventional commits format: `<emoji> type(scope): <one-sentence-summary>`

## Important Instructions

1. **Context-first approach**: If you already have clear context from our conversation about what changes were made, use that information directly to create the commit message. Only run `git status` or `git diff` if the changes aren't clear from the conversation context.

2. **Stage only session files**: Only stage files that were actually modified during this session, not all changed files in the repository.

3. **Add bullet points for significant commits**: For medium to large commits, add 3-5 concise bullet points highlighting key changes. This makes commits more searchable and understandable.

## Commit Message Format

```
<emoji> type(scope): <one-sentence-summary>

[For medium/large commits, add bullet points:]
- Key change or feature added
- Important refactoring or fix
- Configuration or setup change
- Performance improvement or optimization
- Documentation or test updates
```

## Examples

### Small commit (no bullets needed):
```
🐛 fix(auth): correct token expiration check
```

### Medium commit:
```
✨ feat(sync): add automated dotfile synchronization

- Created sync.sh script that creates symlinks from ~/.zshrc and ~/.claude/commands/ to repository locations
- Added backup_if_exists() function to save existing configs to ~/.personal-os-backups/ with timestamps
- Implemented create_symlink() with verification logic to ensure symlinks point to valid targets
```

### Large commit:
```
♻️ refactor(api): restructure data layer for better performance

- Replaced sequential database calls in UserRepository.findWithRelations() with batched queries using Promise.all()
- Implemented PostgreSQL connection pooling in DatabaseConfig class with min:10/max:50 connections
- Added Redis caching layer to ProductService.getPopularItems() with 5-minute TTL for frequently accessed data
- Updated all 23 repository methods to use new BatchQueryBuilder pattern instead of individual queries
- Migrated test suite to use MockDataLayer class eliminating need for test database
```

### Configuration commit:
```
🔧 config(zsh): switch git commit helper from sonnet to haiku

- Updated gcai() function in ~/.zshrc to use claude-haiku-4-5 model instead of sonnet
- Modified the model parameter passed to /Users/raduan/.claude/local/claude CLI tool
- Maintained identical prompt structure for consistent commit message formatting
```

### Feature addition with multiple files:
```
🚀 feat(commands): implement deep research query slash command

- Added /deep-research-query command in claude-commands/deep-research-query.md with length and focus area parameters
- Implemented three query depth levels (brief/standard/comprehensive) with different instruction sets
- Created context extraction logic that analyzes conversation history and identifies key technical decisions
- Added template system for generating hyper-specific research prompts based on current problem domain
```

User preferences for commit message: $ARGUMENTS