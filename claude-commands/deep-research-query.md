---
description: Formulate a detailed, hyper-specific research query for deep research agents based on current problem context and conversation history
argument-hint: "[length: brief|standard|comprehensive] [problem context] [optional: specific focus areas]"
---

# Deep Research Query Formulation

Generate a comprehensive, detailed research query for external deep research agents to solve problems requiring up-to-date knowledge or extensive web research.

## Core Outcome:
Produce a meticulously crafted research query that captures ALL relevant context from the current conversation, technical specifics of the problem, and any additional context provided by the user.

## Usage Examples:
- `/deep-research-query` - Standard length query based on current conversation
- `/deep-research-query brief` - Concise 2-3 paragraph query
- `/deep-research-query comprehensive` - Extended query with maximum detail
- `/deep-research-query standard "OAuth implementation"` - Standard length focused on OAuth
- `/deep-research-query brief "performance" "caching"` - Brief query with multiple focus areas

## Length Options:

### Brief (2-3 paragraphs total):
- Core problem statement with essential technical context
- 3-5 key research questions
- Minimal but sufficient detail for targeted research

### Standard (4-6 paragraphs):
- Detailed problem description with context
- Technical environment and constraints
- 5-8 research questions with priorities
- Clear desired outcomes

### Comprehensive (7+ paragraphs):
- Exhaustive problem analysis with full conversation history
- Complete technical stack and architecture details
- 10+ research questions covering all aspects
- Detailed success criteria and application context
- Alternative approaches and edge cases

## Complete Process:

### Step 0: Determine Query Length
Parse first argument to set length (default: standard):
- If $1 is "brief", "standard", or "comprehensive" → use as length
- Otherwise → treat all arguments as context/focus areas

### Step 1: Context Extraction
Analyze the entire conversation to identify:
- The core technical problem being solved
- Programming languages, frameworks, and libraries involved
- Current implementation details and constraints
- Error messages, stack traces, or specific issues encountered
- Architecture patterns and design decisions
- Performance requirements or limitations
- Security considerations

### Step 2: Problem Analysis
From the gathered context, determine:
- The fundamental challenge that needs solving
- Knowledge gaps that require research
- Best practices or patterns that might apply
- Potential solutions that need investigation
- Trade-offs that need evaluation

### Step 3: Query Construction
Create a research query with these components:

1. **Problem Statement** (1-2 paragraphs):
   - Clear description of the technical challenge
   - Current implementation status and what's not working
   - Specific requirements and constraints

2. **Technical Context** (1-2 paragraphs):
   - Technology stack details (versions if relevant)
   - Architecture and design patterns in use
   - Integration points and dependencies
   - Performance/security/scalability requirements

3. **Research Questions** (bullet points):
   - Primary questions that must be answered
   - Secondary questions for comprehensive understanding
   - Edge cases and potential gotchas to investigate

4. **Desired Outcomes** (1 paragraph):
   - What specific information or solutions are needed
   - How the research will be applied
   - Success criteria for the research

5. **Additional Context** (if provided via $ARGUMENTS):
   - User-specified focus areas
   - Related problems or solutions to consider
   - Constraints or preferences

### Step 4: Query Optimization
Refine the query to be:
- **Specific**: Include exact error messages, version numbers, API names
- **Comprehensive**: Cover all aspects mentioned in conversation
- **Actionable**: Clear about what solutions/information are needed
- **Current**: Emphasize need for up-to-date information where relevant
- **Searchable**: Include relevant keywords and technical terms

## Output Format:

### BRIEF Format:
```
## Research Query: [Title]

[1-2 paragraphs: Core problem with essential technical context, current implementation, and what's not working]

**Key Questions:**
1. [Most critical question]
2. [Second priority]
3. [Third priority]

**Research Focus:** [1 sentence on what specific solutions/information needed]
```

### STANDARD Format:
```
## Research Query: [Concise Title]

### Problem Context:
[2-3 paragraphs describing the exact problem, including code snippets, error messages, or specific technical details from the conversation]

### Technical Environment:
- **Language/Framework**: [e.g., Python 3.11, Django 4.2, PostgreSQL 15]
- **Relevant Libraries**: [specific versions if important]
- **Architecture Pattern**: [e.g., REST API, microservices, monolith]
- **Constraints**: [performance, security, compatibility requirements]

### Research Questions:
1. [Primary question - most critical to solve]
2. [Secondary question - important for complete solution]
3. [Tertiary questions - edge cases, best practices, alternatives]

### Desired Research Outcomes:
[1 paragraph describing what the research should produce]
```

### COMPREHENSIVE Format:
```
## Research Query: [Descriptive Title]

### Executive Summary:
[1 paragraph overview of the problem and research needs]

### Detailed Problem Context:
[3-4 paragraphs with full problem description, attempted solutions, specific errors, and current blockers]

### Technical Environment:
- **Core Stack**: [detailed versions and configurations]
- **Dependencies**: [all relevant libraries and services]
- **Architecture**: [detailed pattern description]
- **Infrastructure**: [deployment, scaling, performance specs]
- **Constraints**: [all requirements and limitations]

### Conversation History & Attempts:
[Summary of what has been tried, what failed, partial solutions]

### Research Questions (Priority Order):
**Critical:**
1. [Must be answered for any solution]
2. [Blocker questions]

**Important:**
3. [For optimal solution]
4. [Best practices]

**Nice-to-have:**
5. [Edge cases]
6. [Future considerations]

### Specific Areas to Investigate:
- [Area 1]: [Detailed explanation of why and what]
- [Area 2]: [Specific documentation or examples needed]
- [Area 3]: [Alternative approaches to evaluate]

### Success Criteria:
[What constitutes a complete answer to this research query]

### Application Context:
[How the research will be applied, timeline, team context]

### Additional Context:
${ARGUMENTS:+User specified focus: $ARGUMENTS}
[Any other relevant details, references, or constraints]
```

## Instructions for Query Generation:

1. **Always include specific technical details** - Don't generalize; include exact function names, error codes, version numbers
2. **Maintain problem focus** - Every part of the query should relate back to solving the actual problem
3. **Include conversation history** - Reference specific attempts, failures, or partial solutions already discussed
4. **Highlight unknowns** - Be explicit about what information is missing or uncertain
5. **Suggest research directions** - Include keywords, documentation sources, or similar problems to investigate
6. **Time-sensitive context** - If the problem involves recent changes (e.g., API updates, new library versions), emphasize need for current information

## Example Transformation:

**Conversation Context**: "Implementing user data updates in Django REST API, need deep merge for nested JSON"

**Generated Research Query**:
```
Research Query: Deep Merge Implementation for Nested JSON in Django REST API

Problem Context:
We're implementing a user_data update endpoint in Django REST Framework that needs to support deep merging of nested JSON structures. Current implementation uses Python's dict.update() which only performs shallow merging. The use case involves progressive onboarding data where each API call updates specific nested paths without overwriting other nested data.

Technical Environment:
- Django 4.2 with Django REST Framework
- PostgreSQL with JSONB field for user_data storage
- Python 3.11 standard library preferred
- RESTful API endpoint at /auth/v2/profile/update/user_data/

Research Questions:
1. What are the best practices for deep merging dictionaries in Python using only standard library?
2. How do other Django applications handle progressive JSON updates in JSONB fields?
3. What are the performance implications of different merge strategies for typical user payloads?

[Continue with full detailed query...]
```

Remember: The goal is to provide the research agent with EVERYTHING they need to conduct thorough, targeted research that directly solves the problem at hand.