---
description: Create a new custom slash command with best practices and proper structure
argument-hint: "<command-name> [description] - e.g., 'review-code' 'Comprehensive code review'"
---

# Create Custom Slash Command

Create a new custom slash command: **/$1** with description: **$2**

## Instructions:

1. **Determine the command location:**
   - **Global commands** (available everywhere): `~/.claude/commands/`
   - **Project commands** (project-specific): `./.claude/commands/`

2. **Create the command file** with proper structure and frontmatter

3. **Follow these best practices:**

### **Frontmatter Guidelines:**
```yaml
---
description: Clear, concise description of what the command does
argument-hint: "Expected arguments with examples"
allowed-tools: ["Read", "Write", "Bash"]  # Optional: restrict tool access
model: "claude-4-5-haiku"      # Optional: specify model
---
```

### **Content Structure:**
- **Clear heading** explaining the command's purpose
- **Argument handling** using `$ARGUMENTS`, `$1`, `$2`, etc.
- **Conditional logic** for different argument patterns
- **Examples** of expected usage
- **Structured output** with consistent formatting

### **Command Design Patterns:**

**Simple Command:**
```markdown
# Do X with $1
Perform action on the specified target: $1
```

**Multi-argument Command:**
```markdown
# Process $1 with style $2
Handle $1 using approach: $2

Default style: comprehensive
Available styles: brief, detailed, technical
```

**Conditional Command:**
```markdown
# Smart Analysis
${ARGUMENTS:+Analyze focusing on: $ARGUMENTS}
${ARGUMENTS:-Perform general analysis of the codebase}
```

### **Argument Best Practices:**
- **Use descriptive names** in argument-hint
- **Provide defaults** for optional arguments
- **Handle empty arguments** gracefully
- **Give usage examples** in the description

### **File Organization:**
- **Use clear names**: `review-code.md`, `deploy-check.md`
- **Group related commands** in subdirectories if needed
- **Avoid special characters** in filenames (use hyphens/underscores)

### **Common Command Types:**
- **Analysis commands**: Code review, security check, performance audit
- **Generation commands**: Create boilerplate, generate docs, scaffold components
- **Process commands**: Deploy, test, build, format
- **Information commands**: Summarize, explain, document

## 📋 **Prompt Engineering Best Practices**

### **1. Define Core Outcome**
Every command must clearly state the **primary deliverable**:

```markdown
## Core Outcome:
Generate a production-ready React component with TypeScript, proper props interface, and comprehensive tests.
```

**Why:** Agents need to understand the exact end state expected, not just the process.

### **2. Cover Complete User Journey (CUJ)**
Map out the **full workflow** from start to finish:

```markdown
## Complete User Journey:
1. **Input Analysis** - Examine provided requirements/files
2. **Planning** - Determine approach and identify dependencies
3. **Implementation** - Create/modify code following patterns
4. **Validation** - Test functionality and check quality
5. **Documentation** - Update relevant docs and examples
6. **Handover** - Provide summary of changes made
```

**Why:** Prevents agents from stopping mid-task or missing critical steps.

### **3. Structured Step-by-Step Process**
Break complex tasks into **discrete, actionable steps**:

```markdown
## Process Steps:
### Step 1: Discovery
- Read and analyze $1 (target file/component)
- Identify current patterns and conventions
- Note dependencies and imports

### Step 2: Planning
- Design component interface based on requirements
- Plan file structure and naming
- Identify testing approach

### Step 3: Implementation
- Create component with proper TypeScript types
- Implement functionality following existing patterns
- Add error handling and edge cases

### Step 4: Quality Assurance
- Run linting and type checking
- Create comprehensive tests
- Verify component renders correctly

### Step 5: Integration
- Update exports and imports
- Add to Storybook if applicable
- Update documentation

### Step 6: Handover
- Summarize what was created
- List files modified/created
- Highlight any decisions made
```

### **4. Clear Success Criteria**
Define **measurable outcomes**:

```markdown
## Success Criteria:
- [ ] Component compiles without TypeScript errors
- [ ] All tests pass with >90% coverage
- [ ] Component follows existing design patterns
- [ ] Props interface is properly documented
- [ ] Component is exported and importable
- [ ] No linting errors or warnings
```

### **5. Handle Edge Cases and Errors**
Anticipate **common failure scenarios**:

```markdown
## Error Handling:
- **If target file doesn't exist:** Create new file with boilerplate
- **If dependencies are missing:** Install and update package.json
- **If tests fail:** Debug and fix before completing
- **If types are incorrect:** Refactor interface and update usages
```

### **6. Context Preservation**
Help agents understand **project-specific context**:

```markdown
## Context Requirements:
- Follow existing project patterns in `src/components/`
- Use the project's TypeScript configuration
- Match existing testing patterns (Jest + Testing Library)
- Follow the established component naming convention
- Respect the existing import/export structure
```

### **7. Quality Gates**
Define **mandatory validation steps**:

```markdown
## Required Validations:
1. **Compile Check:** `npm run type-check` must pass
2. **Lint Check:** `npm run lint` must pass clean
3. **Test Check:** `npm run test` must pass all tests
4. **Build Check:** Component must build without errors
```

### **8. Communication Protocol**
Specify **how agents should report progress**:

```markdown
## Progress Reporting:
- **Start:** "Beginning component creation for $1"
- **Planning:** "Analyzed requirements, planning approach..."
- **Implementation:** "Creating component with X features..."
- **Testing:** "Running validation checks..."
- **Complete:** "Component ready. Created X files, modified Y files."
```

### **9. Argument Validation**
Handle **invalid or missing inputs**:

```markdown
## Argument Validation:
- **If $1 is empty:** Prompt user for component name
- **If $2 is invalid:** Use default configuration
- **If conflicting args:** Prioritize and explain choice
```

### **10. Reusability Patterns**
Make commands **composable and flexible**:

```markdown
## Reusability:
- Support multiple input formats (file path, component name, config object)
- Allow style modifiers (--simple, --complex, --with-tests)
- Enable chaining with other commands
- Provide template variations for common use cases
```

## Template for /$1:

```markdown
---
description: $2
argument-hint: "[target] [options]"
---

# $2

Process the target with specified options: $ARGUMENTS

## Usage:
- /$1 target           # Basic usage
- /$1 target detailed  # With options

## Instructions:
[Detailed instructions for Claude on how to execute this command]

**Default behavior:**
[What happens with minimal arguments]

**With options:**
[How different arguments change behavior]
```

---

**Command to create:** `/$1`
**Description:** `$2`
**Location:** Choose global (`~/.claude/commands/`) or project-specific (`./.claude/commands/`)

Create this command file with proper structure, clear instructions, and good argument handling.
