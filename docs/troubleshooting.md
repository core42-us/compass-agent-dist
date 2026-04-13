# Troubleshooting

Current tested terminal baseline: iTerm2 on macOS Apple Silicon. If you use another terminal emulator, include that detail when reporting display, keyboard, approval-card, or paste/input issues.

## The Binary Will Not Run

Check executable permissions:

```bash
chmod +x compass
./compass
```

If macOS blocks the binary, verify the checksum before allowing it in System Settings.

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

Make sure `COMPASS_API_KEY` is set in the same shell where you launch Compass:

```bash
echo "$COMPASS_API_KEY"
```

If it is empty, get a Compass API key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys) and set it:

```bash
export COMPASS_API_KEY="your-api-key"
```

Do not share the printed key value in public issues or logs.

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
- what you typed,
- what you expected,
- what happened instead.

Do not include secrets, API keys, private code, or proprietary logs in public issues.
