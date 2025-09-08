---
description: Summarize conversations with customizable focus areas and styles
argument-hint: "[focus-area] [style] - e.g., 'frontend architecture' or 'bug-fixes handover'"
---

# Conversation Summary

Create a comprehensive summary of our conversation focusing on $ARGUMENTS.

## Instructions:

**Default behavior (no arguments):**
- Provide a structured summary of the entire conversation
- Include context, goals, decisions made, and outcomes
- Focus on actionable insights and key details

**Focus areas (examples):**
- Any domain-specific topic (e.g., "frontend", "API design", "database", "security")
- Process aspects (e.g., "decisions", "implementation", "testing", "deployment")
- Problem areas (e.g., "bugs", "performance", "refactoring", "optimization")
- Project phases (e.g., "planning", "architecture", "development", "review")

**Style modifiers:**
- **brief**: Concise bullet-point summary
- **detailed**: Comprehensive explanation with context
- **handover**: Formatted for passing to another developer/agent
- **technical**: Focus on code, APIs, and implementation details

## Summary Structure:

### 🎯 **Context & Goals**
- What we were trying to achieve
- Background and constraints
- Success criteria

### 📋 **Key Decisions Made** 
- Important choices and trade-offs
- Alternatives considered
- Rationale behind decisions

### 🔧 **Implementation Details**
- What was built/changed
- Technical approach taken
- Code structure and patterns

### ✅ **Outcomes & Results**
- What was accomplished
- Issues resolved
- Current state

### 📝 **For Future Reference**
- Key learnings
- Patterns to reuse
- Things to remember for next time

---

**Focus the summary on: $ARGUMENTS**

Make it useful for handover to another developer or for future reference when returning to this work.