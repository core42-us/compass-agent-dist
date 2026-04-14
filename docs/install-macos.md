# Install Compass On macOS Apple Silicon

## Requirements

- macOS on Apple Silicon
- iTerm2. Other terminal emulators may work, but iTerm2 is the current tested baseline.
- GPT-5 access for the Compass API key/resource. This release was tested only with GPT-5.
- A Compass release archive named `compass-darwin-arm64.zip`

Recommended for developer workflows:

- `git` for repository-aware status, diff, and history tasks.
- `rg` from `ripgrep` for fast code search. Compass can fall back when `rg` is missing, but repo review and code search flows are better with it installed.

With Homebrew:

```bash
brew install git ripgrep
```

## Install

### Homebrew

```bash
brew tap core42-us/compass-agent-dist
brew install compass
compass init
compass doctor
compass
```

The tap lives in the same public distribution repo as the release metadata, checksums, and docs.

### Direct ZIP

Download `compass-darwin-arm64.zip` from the latest public release, then run:

```bash
unzip compass-darwin-arm64.zip
./compass-darwin-arm64 init
./compass-darwin-arm64 doctor
./compass-darwin-arm64
```

To install it on your shell path:

```bash
mkdir -p ~/.local/bin
mv compass-darwin-arm64 ~/.local/bin/compass
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
exec zsh
compass
```

If `~/.local/bin` is already on your `PATH`, you can skip the shell profile update.

## API Key

Compass needs a Compass API key, model name, and model-request timeout before model-backed workflows can run. Get your key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys), then run setup:

```bash
compass init --api-key "your-api-key"
compass doctor
```

`compass init` writes non-secret settings to `~/.compass/settings.json` and stores the API key in macOS Keychain when available. This release was tested with GPT-5 and a 300 second timeout, so the generated settings default to `gpt-5` and `COMPASS_TIMEOUT_SECONDS=300` behavior.

Environment variables like `COMPASS_API_KEY`, `COMPASS_MODEL=gpt-5`, and `COMPASS_TIMEOUT_SECONDS=300` still work for CI or temporary shell overrides, but they are no longer the preferred local setup path.

The Compass documentation notes that generated API keys are shown only once, so store the key securely. This release was tested with GPT-5, so make sure the API key/resource you use has GPT-5 access. Keep API keys out of public issues, screenshots, prompts, and shared logs.

`COMPASS_TIMEOUT_SECONDS=300` is the recommended starting point. If long repo-review, comparison, or implementation prompts frequently time out, increase it for that shell session, for example `export COMPASS_TIMEOUT_SECONDS="600"`.

## Verify Checksum

From the directory containing the downloaded archive:

```bash
shasum -a 256 compass-darwin-arm64.zip
```

Compare the result with the checksum published for the same release in `checksums/compass-darwin-arm64.zip.sha256` or the release notes.

## macOS Security Prompt

Mac releases are moving to Developer ID signed and notarized ZIP archives. If macOS still blocks Compass on first run:

1. Verify the checksum against the release notes.
2. Open System Settings.
3. Go to Privacy & Security.
4. Allow the blocked Compass binary only if the checksum and release source match.

Do not bypass Gatekeeper for a binary from an unknown or mismatched source.
