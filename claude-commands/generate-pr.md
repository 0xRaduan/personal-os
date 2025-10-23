---
description: Generate PR description following repo template with high information density
argument-hint: "[pr-number]"
allowed-tools: ["Read", "Bash", "Grep", "Glob"]
---

# Generate Pull Request Description

Create a concise, high-impact PR description that follows the repository's PR template format.

## Core Outcome
Generate a complete PR description that:
- Follows the repo's `.github/pull_request_template.md` structure (if exists)
- Maximizes information density - no fluff, only essential details
- Focuses on technical changes and business impact
- Uses clear, scannable formatting

## Usage
- `/generate-pr` - Create new PR or update existing PR for current branch
- `/generate-pr 123` - Update existing PR #123

## Complete User Journey

### Step 1: Discovery & PR Detection
- Detect current branch or use provided PR number
- Check if PR exists for current branch:
  ```bash
  gh pr view --json number,title,body,headRefName 2>/dev/null
  ```
- **If PR exists:** Fetch PR details for updating
- **If no PR exists:** Prepare to create new PR
- Read repo's PR template (`.github/pull_request_template.md` or `.github/PULL_REQUEST_TEMPLATE.md`)
- Get list of changed files:
  - For existing PR: `gh pr diff --name-only`
  - For new PR: `git diff origin/master..HEAD --name-only` (or use detected base branch)

### Step 2: Analysis
- Read key changed files to understand scope
- Review commit messages for context
- Identify the type of change (feature, fix, refactor, etc.)
- Extract technical details from code changes

### Step 3: Content Generation
Follow the repo's template structure exactly. If no template exists, use this default:

```markdown
## Summary
[One-line technical description]

## Key Changes
- [Specific technical change with file/function references]
- [Business impact or user-facing change]
- [Performance/architecture improvements]

## Testing
- [x] [Specific test performed]
- [x] [Edge cases verified]
```

### Step 4: Writing Guidelines
**Information Density Principles:**
- **Be specific**: "Reduced bundle size by 45KB" not "Improved performance"
- **Reference code**: "Updated `UserAuth.handleLogin()` to use async/await" not "Fixed login"
- **Quantify**: "16 files, 3 components, 2 APIs" not "Multiple files"
- **Skip obvious**: Don't explain what's clear from diffs
- **Front-load value**: Most important changes first

**Conciseness Rules:**
- Remove filler words: "basically", "just", "simply", "actually"
- Use active voice: "Refactored X" not "X was refactored"
- Bullet points over paragraphs
- Technical terms over verbose explanations
- One idea per bullet

### Step 5: Template Adaptation
Match the repo's template sections:
- If template has "Context" → Add brief "why" with links to issues/specs
- If template has "Architecture" → Include mermaid diagram for complex flows
- If template has "Testing" → List specific test scenarios
- If template has custom sections → Follow them exactly

### Step 6: Create or Update PR
**For new PRs:**
- Generate title from first commit or branch name
- Create PR with: `gh pr create --title "..." --body "$(cat <<'EOF' ... EOF)"`
- Use detected base branch (usually master/main)

**For existing PRs:**
- Get PR node ID: `gh pr view [number] --json id --jq '.id'`
- Update using GraphQL API (avoids deprecated Projects classic warnings):
  ```bash
  gh api graphql -F pullRequestId="$PR_ID" -F body="$DESCRIPTION" -f query='
  mutation($pullRequestId: ID!, $body: String!) {
    updatePullRequest(input: {pullRequestId: $pullRequestId, body: $body}) {
      pullRequest { number body }
    }
  }'
  ```
- Preserve existing title, labels, assignees, etc.

## Success Criteria
- [ ] Follows repo's PR template structure exactly
- [ ] Every bullet point adds unique technical value
- [ ] No generic/filler content
- [ ] Changed files are reflected in description
- [ ] Technical details are specific (file paths, function names, metrics)
- [ ] Business impact is clear when relevant

## Error Handling
- **If no PR template exists:** Use default minimal structure above
- **If gh CLI not available:** Ask user to install it
- **If not in a git repo:** Error and exit
- **If PR number invalid:** Error with available PR list
- **If current branch has no PR:** Create new PR with generated description
- **If branch not pushed to remote:** Push branch first, then create PR
- **If no commits on branch:** Error - nothing to create PR for

## Context Requirements
- Detect and respect the repository's existing conventions
- Match the tone/style of previous PRs if template is generic
- For frontend changes: mention components/pages
- For backend changes: mention APIs/services/models
- For both: mention integration points

## Example Output Quality

**Bad (fluffy, vague):**
```
## Summary
This PR improves the user experience by making some changes to the authentication flow.

## Key Changes
- Updated the login page
- Fixed some bugs
- Made things faster
```

**Good (dense, specific):**
```
## Summary
Refactored authentication to use async token refresh, reducing login latency by 300ms.

## Key Changes
- `auth/login.ts:45` - Replaced sync token validation with async refresh strategy
- `middleware/auth-check.ts` - Added Redis caching (5min TTL) for JWT verification
- `LoginPage.tsx` - Removed blocking spinner, added optimistic UI

## Testing
- [x] Verified token refresh on expiry (tested with 1min TTL)
- [x] Confirmed Redis fallback when cache misses
- [x] Load tested 1000 concurrent logins (no degradation)
```

## Process Steps

1. **Detect PR context**
   ```bash
   # Check if PR exists
   gh pr view --json number,title,body,headRefName 2>/dev/null
   # Exit code 0 = PR exists, non-zero = no PR
   ```

2. **Determine base branch**
   ```bash
   # Get repository default branch
   gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'
   ```

3. **Read PR template**
   ```bash
   # Check for template (case variations)
   test -f .github/pull_request_template.md || test -f .github/PULL_REQUEST_TEMPLATE.md
   ```

4. **Analyze changes**
   ```bash
   # For existing PR:
   gh pr diff --name-only

   # For new PR:
   git diff origin/master..HEAD --name-only
   # Or use detected base branch
   ```

5. **Review commits**
   ```bash
   # Get commit messages for context
   git log origin/master..HEAD --oneline
   # Use for generating PR title if creating new PR
   ```

6. **Read key files**
   - Prioritize core logic files over config
   - Focus on files with most changes
   - Extract technical details and impacts

7. **Generate description**
   - Follow template structure exactly
   - Apply information density principles
   - Include specific technical details
   - Quantify impact where possible

8. **Create or Update PR**
   ```bash
   # For new PR:
   gh pr create --title "..." --body "$(cat <<'EOF'
   [generated content]
   EOF
   )"

   # For existing PR (using GraphQL API to avoid deprecated Projects classic):
   # First, get PR node ID:
   PR_ID=$(gh pr view [number] --json id --jq '.id')

   # Then update using GraphQL mutation:
   gh api graphql -F pullRequestId="$PR_ID" -F body="[generated content]" -f query='
   mutation($pullRequestId: ID!, $body: String!) {
     updatePullRequest(input: {pullRequestId: $pullRequestId, body: $body}) {
       pullRequest {
         number
         body
       }
     }
   }'

   # Alternative: Write description to temp file and use:
   gh api graphql -F pullRequestId="$PR_ID" -F body="$(cat /tmp/pr-description.md)" -f query='...'
   ```

## Output Format
Present the generated description to the user first, then proceed with creating/updating.

**For new PRs:**
```
Generated PR:
─────────────────────────
Title: [generated title]

[preview of description]
─────────────────────────

Creating PR...
```

**For existing PRs:**
```
Updated PR description:
─────────────────────────
[preview of description]
─────────────────────────

Updating PR #123...
```
