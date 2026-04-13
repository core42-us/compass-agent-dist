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

Download `compass-darwin-arm64.zip` from the latest public release, then run:

```bash
unzip compass-darwin-arm64.zip
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

Compass needs a Compass API key, model name, and model-request timeout before model-backed workflows can run. Get your key from [Core42 Compass API key documentation](https://www.core42.ai/compass/documentation/manage-api-keys), then set it with the tested model and recommended timeout in your shell:

```bash
export COMPASS_API_KEY="your-api-key"
export COMPASS_MODEL="gpt-5"
export COMPASS_TIMEOUT_SECONDS="300"
```

To keep it for future terminal sessions:

```bash
echo 'export COMPASS_API_KEY="your-api-key"' >> ~/.zshrc
echo 'export COMPASS_MODEL="gpt-5"' >> ~/.zshrc
echo 'export COMPASS_TIMEOUT_SECONDS="300"' >> ~/.zshrc
exec zsh
```

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
