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
export COMPASS_API_KEY="your-api-key"
export COMPASS_MODEL="gpt-5"
export COMPASS_TIMEOUT_SECONDS="300"
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

## 3. Approvals

Compass may ask before higher-risk actions, including:

- reading local paths outside the current workspace,
- changing files,
- running commands,
- changing repository state.

Approve only if the requested path, command, or write action matches what you intended. Deny if the request is surprising or broader than your task.

## 4. Multi-Repo Workspaces

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

## 5. Useful Commands

```text
/help
/status
/session list
/session new <name>
/exit
```

Use `/help` first if you are unsure which command exists in the current release.

## 6. Recommended Tools

Compass can launch without these, but developer workflows are better when they are installed:

```bash
brew install git ripgrep
```

`git` enables repository status, diffs, history, and branch-aware workflows. `ripgrep` provides `rg`, which improves repo-wide search speed and ignore-file behavior.

## 7. API Key And Model

Get a Compass API key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys).

Set:

```bash
export COMPASS_API_KEY="your-api-key"
export COMPASS_MODEL="gpt-5"
export COMPASS_TIMEOUT_SECONDS="300"
```

The Compass documentation notes that generated API keys are shown only once, so store the key securely. This release was tested with GPT-5, so make sure the API key/resource you use has GPT-5 access.

Do not paste API keys into public issues, screenshots, prompts, or shared logs.

## 8. Common Issues

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

## 9. Reporting Issues

Include:

- Compass release tag or version line from startup,
- macOS version and chip architecture,
- terminal emulator and version,
- model name and whether your API key/resource has access to it,
- timeout value,
- what you typed,
- what happened instead.

Do not include secrets, API keys, private code, or proprietary logs in public issues.
