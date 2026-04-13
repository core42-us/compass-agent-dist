# Compass Prompt Library

Use these prompts as starting points. Replace paths and service names with your own.

## Repo Review

```text
look at this repo and give me feedback; show concrete findings first and cite files
```

```text
review my current changes and focus on bugs, regressions, missing tests, and risky assumptions
```

```text
find security-sensitive code paths in this repo and summarize the top risks with file references
```

## Code Understanding

```text
explain how auth works in this repo with file references and a short request-flow summary
```

```text
map the main runtime loop and identify the most important packages/files to read next
```

```text
summarize the command surface and point out commands that look risky or under-documented
```

```text
find where this function/type/config value is defined and show the most important references
```

```text
trace how this field moves from request handling to persistence and summarize risky assumptions
```

```text
identify the likely impacted files and tests for this change before editing anything
```

## New Teammate Or Intern Onboarding

```text
give me a beginner-friendly map of this repo: what it does, main folders, important entrypoints, and where to read first
```

```text
explain the main request flow with file references; separate what is certain from what is inferred
```

```text
help me understand this issue before editing: summarize the likely code area, terms I need to know, and files to inspect
```

```text
find a small safe starter task in this repo and explain what files and tests I should understand first
```

```text
before editing anything, list the likely files, tests, risks, and questions I should ask a teammate
```

```text
make the smallest safe change for this starter task, run targeted tests, and summarize changed files
```

## Multi-Repo And Microservices Workspaces

Start Compass in one repo, then refer to sibling repos by path. Compass will ask for approval before reading outside the current workspace.

```text
compare this repo to ../orders-service and summarize shared dependencies, API boundaries, and duplicated code
```

```text
look across this repo and ../billing-service to find where payment status is produced, transformed, and consumed
```

```text
for this change, inspect this repo plus ../api-gateway and ../worker-service and tell me which services might be impacted
```

```text
map the dependency flow between ../web-app, ../api-gateway, and this service; separate direct evidence from assumptions
```

```text
find cross-repo references to the customer id contract across this repo, ../customer-service, and ../reporting-service
```

```text
trace the customer id contract across this repo, ../customer-service, and ../reporting-service; separate direct code evidence from assumptions
```

```text
compare the release risk for this repo and ../shared-library; list compatibility concerns and tests to run before shipping
```

## Implementation

```text
make the smallest safe change for this bug, run targeted tests, and summarize changed files
```

```text
add regression coverage for this behavior before changing code, then run the relevant tests
```

```text
fix the failing test, explain the root cause, and avoid broad refactors unless needed
```

## Architecture And Product Design

```text
compare 2-3 architecture options for this feature, list tradeoffs, and recommend one
```

```text
draft an ADR-ready recommendation for this design; separate decision, context, alternatives, and consequences
```

```text
help define this product feature, list assumptions separately from evidence, and propose a phased roadmap
```

## Release And SRE

```text
design the CI/CD release plan and rollback workflow for this service
```

```text
draft release notes, validation evidence, rollback steps, and residual risks from the current git changes
```

```text
triage this incident with read-only evidence first; summarize what was checked, likely causes, and next safe actions
```

```text
write a postmortem draft from the incident timeline; separate impact, root cause, contributing factors, and follow-ups
```

## Prompting Tips

- Ask for the outcome you want, not just the topic.
- For review/debugging, ask for concrete findings first.
- For large work, ask Compass to separate evidence from assumptions.
- For multi-repo work, name the repos or paths explicitly and approve only the paths you intended.
- For implementation, ask Compass to run targeted tests and summarize changed files.
