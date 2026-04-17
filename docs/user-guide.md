# Compass User Guide

This guide covers day-to-day Compass usage after installation.

Current tested baseline:

- macOS Apple Silicon
- iTerm2
- GPT-5 via `COMPASS_MODEL="gpt-5"`

Other terminals or model configurations may work, but they are not part of the current tested baseline.

## 1. Start In A Repository

Run Compass from the repository you want it to inspect:

```bash
compass init --api-key "your-api-key" --trust-current-repo
compass doctor
cd /path/to/your/repo
compass
```

If long repo-review, comparison, or implementation turns time out often, try:

```bash
export COMPASS_TIMEOUT_SECONDS="600"
```

## 2. Good First Prompts

Use direct, task-shaped prompts:

```text
look at this repo and give me feedback
compare this repo to ../other-repo and summarize the important differences
explain how auth works with file references
review my current changes and show concrete findings first
fix the failing test and run the relevant checks
design the CI/CD release plan and rollback workflow
triage this incident with read-only evidence first
```

For large tasks, describe the outcome you want:

```text
compare the two approaches, list tradeoffs, and recommend one
make the smallest safe change, run targeted tests, and summarize changed files
draft release notes, rollback steps, and validation evidence
```

## 3. New Teammate Or Intern Workflow

If you are new to a repo, start with read-only understanding before asking Compass to edit code.

Suggested first sequence:

```text
give me a beginner-friendly map of this repo: what it does, main folders, important entrypoints, and where to read first
```

```text
explain the main request flow with file references; separate what is certain from what is inferred
```

```text
find a small safe starter task in this repo and explain what files and tests I should understand first
```

```text
before editing anything, list the likely files, tests, and risks for this change
```

Once you understand the area, move to implementation:

```text
make the smallest safe change for this starter task, run targeted tests, and summarize changed files
```

Tip: if Compass asks for approval to read a sibling repo or make a write-side change, pause and confirm the path/action matches your task. When learning a repo, denying broad or surprising actions is fine.

## 4. Approvals

Compass may ask before higher-risk actions, including:

- reading local paths outside the current workspace,
- changing files,
- running commands,
- changing repository state.

Approve only if the requested path, command, or write action matches what you intended. Deny if the request is surprising or broader than your task.

## 5. Multi-Repo Workspaces

For microservices or multi-repo systems, start Compass in the repo you are working on and refer to sibling repos by path:

```bash
cd /path/to/orders-service
compass
```

Example prompts:

```text
compare this repo to ../billing-service and summarize shared dependencies, API boundaries, and duplicated code
```

```text
for this change, inspect this repo plus ../api-gateway and ../worker-service and tell me which services might be impacted
```

```text
map the dependency flow between ../web-app, ../api-gateway, and this service; separate direct evidence from assumptions
```

Compass will ask before reading paths outside the current workspace. Approve only the sibling repo paths you intended it to inspect.

For more examples, see [prompt-library.md](prompt-library.md).

## 6. Code Intelligence

Compass uses code structure to make repo answers more grounded. You do not need to know the implementation details to benefit from it.

This helps when you ask Compass to:

- find where a function, type, route, or config value is defined,
- find likely references and call sites,
- trace how data moves across files or services,
- identify which files or services may be affected by a change,
- explain architecture with file-backed evidence instead of generic summaries,
- review code with fewer guesses and more concrete references.

Example prompts:

```text
find where payment status is defined and show the main places it is consumed
```

```text
for this change, identify the likely impacted files and tests before editing anything
```

```text
trace how customer id flows from the API layer to persistence and point out risky assumptions
```

For multi-repo systems, combine this with workspace prompts:

```text
trace the customer id contract across this repo, ../customer-service, and ../reporting-service
```

## 7. VS Code And Editor Workflows

Compass can be used from VS Code today through its bridge commands and local HTTP bridge. This is the integration surface intended for VS Code extensions, editor panels, and command-palette actions. Bridge commands are clients, so start `compass server` first.

### Use VS Code Tasks

Create `.vscode/tasks.json` in your repo:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Compass: Review Current Changes",
      "type": "shell",
      "command": "compass bridge workflow-stream vscode-review -- \"review my current changes and show concrete findings first\"",
      "problemMatcher": [],
      "presentation": {
        "reveal": "always",
        "panel": "dedicated",
        "clear": false
      }
    }
  ]
}
```

Run the task from VS Code with `Terminal: Run Task`.

Before running bridge tasks, start the local server from the repo:

```bash
cd /path/to/your/repo
compass server --addr 127.0.0.1:8787 --repo-dir "$PWD"
```

Useful bridge commands:

```bash
compass bridge status
compass bridge summary
compass bridge workflow-stream vscode-review -- "summarize current repo changes"
compass bridge continue "continue from the previous answer and propose next tests"
compass bridge session history latest 10
compass bridge tasks output latest
```

`workflow-stream` is usually the best editor command because it creates or reuses a session, streams progress, and prints next-step session/task context at the end.

### Use The Local HTTP Bridge

For a custom VS Code extension or internal editor adapter:

```bash
compass server --addr 127.0.0.1:8787 --repo-dir /path/to/repo
```

Example bridge calls:

```bash
curl -s http://127.0.0.1:8787/v1/bridge/status | jq .
curl -s -X POST http://127.0.0.1:8787/v1/bridge/bootstrap \
  -H 'Content-Type: application/json' \
  -d '{"client_name":"vscode","label":"review-panel"}' | jq .
curl -s -X POST http://127.0.0.1:8787/v1/bridge/workflow \
  -H 'Content-Type: application/json' \
  -d '{"client_name":"vscode","label":"review-panel","prompt":"summarize current repo changes"}' | jq .
```

Bridge responses include session ids, task status, recent activity, structured file references, and editor states such as `idle`, `executing`, `awaiting_approval`, `completed`, `failed`, or `task_running`.

### Editor Code Intelligence

These bridge commands are useful as command-palette actions:

```bash
compass bridge lsp status
compass bridge lsp symbols Volume
compass bridge lsp definition src/App.tsx:42:5
compass bridge lsp references src/App.tsx:42:5
compass bridge lsp hover src/App.tsx:42:5
```

When a language server is unavailable, Compass falls back to internal semantic analysis where possible. `lsp status` shows whether a server came from `PATH`, explicit config, or a Compass-managed install location.

## 8. MCP For Jira, Confluence, And Knowledge Sources

MCP, the Model Context Protocol, lets Compass read tools and resources exposed by remote context servers. Use it when the relevant information is outside the local git checkout: Jira tickets, Confluence pages, runbooks, service catalogs, release checklists, or incident notes.

Compass does not require a specific Atlassian MCP server. Your team can choose one and provide Compass with the server's stdio command.

### Configure One MCP Server

```bash
export COMPASS_MCP_STDIO_COMMAND="node /path/to/mcp-server.js"
compass
```

Inspect it inside Compass:

```text
/mcp status
/mcp doctor
/mcp tools
/mcp resources
/mcp resources auth
```

### Configure Jira And Confluence Together

Example shape:

```bash
export ATLASSIAN_SITE_URL="https://your-company.atlassian.net"
export ATLASSIAN_EMAIL="you@company.com"
export ATLASSIAN_API_TOKEN="stored-outside-git"
export COMPASS_MCP_STDIO_COMMANDS="node /opt/mcp/atlassian-jira-server.js;node /opt/mcp/atlassian-confluence-server.js"
compass
```

Keep tokens in your shell, Keychain, secret manager, or the MCP server's own secure config. Do not commit API tokens to git.

### Jira Examples

```text
Read Jira ticket AUTH-123 through MCP, inspect the local auth code, and tell me what files likely need changes.
```

```text
Use Jira context for PAY-456 and this repo's git diff to draft a concise PR description with risks and test evidence.
```

```text
Compare the acceptance criteria in Jira ticket OPS-789 with the current implementation and list gaps with file references.
```

Bridge/editor examples:

```bash
compass bridge mcp resources AUTH-123
compass bridge mcp read jira://AUTH-123
compass bridge workflow-stream vscode-jira -- "Using the selected Jira context, review current changes for acceptance criteria gaps"
```

Resource URI formats such as `jira://AUTH-123` depend on the MCP server you configure.

### Confluence Examples

```text
Use the Confluence auth architecture page and this repo to explain whether the implementation matches the documented design.
```

```text
Read the release runbook from Confluence, inspect this repo's CI/CD files, and create a release checklist with gaps.
```

```text
Compare the Confluence incident runbook with the current logging and alerting code paths; cite files for any mismatch.
```

Bridge/editor examples:

```bash
compass bridge mcp resources "auth architecture"
compass bridge mcp resources "release runbook"
compass bridge mcp read confluence://SPACE/page/123456
```

Good MCP habits:

- Ask Compass to cite both remote resource names/URIs and local file paths.
- Start read-only, then ask for edits after the ticket/wiki context is clear.
- Keep secrets out of prompts, screenshots, public issues, and shared logs.
- If a remote resource is large, ask for one focused ticket, page, or section first.

## 9. Useful Commands

```text
/help
/status
/session list
/session new <name>
/exit
```

Use `/help` first if you are unsure which command exists in the current release.

## 10. Recommended Tools

Compass can launch without these, but developer workflows are better when they are installed:

```bash
brew install git ripgrep
```

`git` enables repository status, diffs, history, and branch-aware workflows. `ripgrep` provides `rg`, which improves repo-wide search speed and ignore-file behavior.

## 11. API Key And Model

Get a Compass API key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys).

Set:

```bash
export COMPASS_API_KEY="your-api-key"
export COMPASS_MODEL="gpt-5"
export COMPASS_TIMEOUT_SECONDS="300"
```

The Compass documentation notes that generated API keys are shown only once, so store the key securely. This release was tested with GPT-5, so make sure the API key/resource you use has GPT-5 access.

Do not paste API keys into public issues, screenshots, prompts, or shared logs.

## 12. Common Issues

If the binary does not run:

```bash
chmod +x compass
./compass
```

If `compass` is not found, make sure its install directory is on `PATH`.

If model requests fail, check:

```bash
echo "$COMPASS_API_KEY"
echo "$COMPASS_MODEL"
echo "$COMPASS_TIMEOUT_SECONDS"
```

If repo search feels slow, install `ripgrep`:

```bash
brew install ripgrep
```

See [troubleshooting.md](troubleshooting.md) for more detail.

## 13. Reporting Issues

Include:

- Compass release tag or version line from startup,
- macOS version and chip architecture,
- terminal emulator and version,
- model name and whether your API key/resource has access to it,
- timeout value,
- what you typed,
- what happened instead.

Do not include secrets, API keys, private code, or proprietary logs in public issues.
