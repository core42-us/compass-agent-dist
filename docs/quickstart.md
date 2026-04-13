# Compass Quickstart

Start Compass from a repository:

```bash
export COMPASS_API_KEY="your-api-key"
export COMPASS_MODEL="gpt-5"
export COMPASS_TIMEOUT_SECONDS="300"
cd /path/to/your/repo
compass
```

Get a Compass API key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys). The Compass documentation notes that generated API keys are shown only once, so store the key securely. This release was tested with GPT-5, so make sure the API key/resource you use has GPT-5 access. Do not paste API keys into public issues, screenshots, prompts, or shared logs.

Try:

```text
look at this repo and give me feedback
compare this repo to ../other-repo and summarize the important differences
explain how auth works with file references
fix the failing test and run the relevant checks
design the CI/CD release plan and rollback workflow
```

Compass may ask for approval before reading paths outside the current workspace or before making write-side changes. Approve only when the requested path, command, or write action matches what you intended.

For a broader walkthrough, see [user-guide.md](user-guide.md). For scenario-based examples, see [prompt-library.md](prompt-library.md).

Useful commands:

```text
/help
/status
/session list
/session new <name>
/exit
```
