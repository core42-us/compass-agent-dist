# Compass Quickstart

Start Compass from a repository:

```bash
export COMPASS_API_KEY="your-api-key"
cd /path/to/your/repo
compass
```

Get a Compass API key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys). The Compass documentation notes that generated API keys are shown only once, so store the key securely. Do not paste API keys into public issues, screenshots, prompts, or shared logs.

Try:

```text
look at this repo and give me feedback
compare this repo to ../other-repo and summarize the important differences
explain how auth works with file references
fix the failing test and run the relevant checks
design the CI/CD release plan and rollback workflow
```

Compass may ask for approval before reading paths outside the current workspace or before making write-side changes. Approve only when the requested path, command, or write action matches what you intended.

Useful commands:

```text
/help
/status
/session list
/session new <name>
/exit
```
