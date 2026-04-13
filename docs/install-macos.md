# Install Compass On macOS Apple Silicon

## Requirements

- macOS on Apple Silicon
- iTerm2. Other terminal emulators may work, but iTerm2 is the current tested baseline.
- A Compass release binary named `compass-darwin-arm64`

Recommended for developer workflows:

- `git` for repository-aware status, diff, and history tasks.
- `rg` from `ripgrep` for fast code search. Compass can fall back when `rg` is missing, but repo review and code search flows are better with it installed.

With Homebrew:

```bash
brew install git ripgrep
```

## Install

Download `compass-darwin-arm64` from the latest public release, then run:

```bash
chmod +x compass-darwin-arm64
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

## Verify Checksum

From the directory containing the downloaded binary:

```bash
shasum -a 256 compass
```

Compare the result with the checksum published for the same release in `checksums/compass-darwin-arm64.sha256` or the release notes.

## macOS Security Prompt

If macOS blocks Compass on first run:

1. Verify the checksum against the release notes.
2. Open System Settings.
3. Go to Privacy & Security.
4. Allow the blocked Compass binary only if the checksum and release source match.

Do not bypass Gatekeeper for a binary from an unknown or mismatched source.
