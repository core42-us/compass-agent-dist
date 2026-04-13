# Troubleshooting

Current tested baseline: iTerm2 on macOS Apple Silicon with GPT-5. If you use another terminal emulator or model configuration, include that detail when reporting display, keyboard, approval-card, paste/input, or model-response issues.

## The Binary Will Not Run

Prefer the release ZIP archive:

```bash
unzip compass-darwin-arm64.zip
./compass-darwin-arm64
```

Check executable permissions:

```bash
chmod +x compass
./compass
```

Mac releases are moving to Developer ID signed and notarized ZIP archives. If macOS still blocks the binary, verify the ZIP checksum and release source before allowing it in System Settings.

## `compass` Command Not Found

Make sure the install directory is on your shell path:

```bash
echo "$PATH"
ls -l ~/.local/bin/compass
```

For zsh:

```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh
```

## Model Requests Fail Or Ask For Credentials

Make sure `COMPASS_API_KEY`, `COMPASS_MODEL`, and `COMPASS_TIMEOUT_SECONDS` are set in the same shell where you launch Compass:

```bash
echo "$COMPASS_API_KEY"
echo "$COMPASS_MODEL"
echo "$COMPASS_TIMEOUT_SECONDS"
```

If the key is empty, get a Compass API key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys) and set it:

```bash
export COMPASS_API_KEY="your-api-key"
export COMPASS_MODEL="gpt-5"
export COMPASS_TIMEOUT_SECONDS="300"
```

Do not share the printed key value in public issues or logs.

If credentials are set but model requests still fail, confirm that the API key/resource has GPT-5 access. This release was tested only with GPT-5.

## Frequent Timeouts

The recommended starting timeout is:

```bash
export COMPASS_TIMEOUT_SECONDS="300"
```

If long repo-review, comparison, or implementation prompts frequently time out, try a larger value for that shell session:

```bash
export COMPASS_TIMEOUT_SECONDS="600"
```

If a prompt still times out at a higher value, include the timeout value and prompt type when reporting the issue.

## Search Feels Slow Or Less Complete

Install `ripgrep` so Compass can use `rg` for fast repository search:

```bash
brew install ripgrep
```

Compass can fall back when `rg` is unavailable, but `ripgrep` is recommended for repo review, comparison, and code understanding tasks.

## Compass Asks For Approval

Compass asks before higher-risk actions, such as:

- reading local paths outside the current workspace,
- changing files,
- running commands,
- changing repository state.

Approve only if the requested action matches your intent.

## Reporting Issues

Include:

- Compass release tag or version line from startup,
- macOS version,
- chip architecture,
- terminal emulator and version,
- model name and whether your API key/resource has access to it,
- what you typed,
- what you expected,
- what happened instead.

Do not include secrets, API keys, private code, or proprietary logs in public issues.
