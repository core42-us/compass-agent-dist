# Compass

Compass is a local-first coding assistant for developers who want repo-aware help with code review, design, implementation, release planning, and production support workflows.

This repository is the public distribution surface for Compass. It contains install docs, release notes, checksums, and public release metadata. The source repository is private.

## Install On macOS Apple Silicon

Download the latest `compass-darwin-arm64` binary from the public release page, then:

```bash
chmod +x compass-darwin-arm64
./compass-darwin-arm64
```

Optional local install:

```bash
mkdir -p ~/.local/bin
mv compass-darwin-arm64 ~/.local/bin/compass
compass
```

If macOS blocks the first launch, verify that the checksum matches the published release before allowing the binary in System Settings.

## Verify A Download

```bash
shasum -a 256 compass-darwin-arm64
cat checksums/compass-darwin-arm64.sha256
```

The two SHA-256 values should match for the release you downloaded.

## First Run

```bash
compass
```

Useful first prompts:

```text
compare this repo to ../other-repo and summarize the important architectural differences
review my current changes and show concrete findings first
fix the failing test, run the relevant tests, and summarize changed files
explain how auth works in this repo with file references
```

## Current Distribution Scope

- macOS Apple Silicon first: `compass-darwin-arm64`
- public docs and release notes in this repo
- checksums per release
- Homebrew planned after release naming and upgrade/rollback docs stabilize

## Support

When reporting an issue, include:

- Compass version or release tag
- macOS version and chip architecture
- the command or prompt you ran
- whether the issue happened during install, startup, approval, tool use, or final answer generation

Do not paste secrets, API keys, private source code, or proprietary logs into public issues.
