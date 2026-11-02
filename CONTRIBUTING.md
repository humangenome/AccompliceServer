# Contributing to AccompliceServer

Short and to the point.

## Where to report

The server and the player mod are the same file, so bugs in either one go to [this repo's issues](https://github.com/HumanGenome/AccompliceServer/issues): a server that will not start, saves, ports, the status check and settings, and also joining, chat, voice and the co-op itself in a player's game.

If your issue is about a server you rent (the control panel, billing or support), contact your host directly. These GitHub issues are for Accomplice itself.

## Reporting bugs

Open an issue using the **Bug report** template. Include:

- The Accomplice version (the release tag, e.g. `v0.1.1`, or the version the server's log prints)
- Your Probably Stolen build (Steam build ID if you know it)
- Host OS, if it happened on a server
- Steps to reproduce
- The server's log (the `-logFile` path), and the player's game log if it happened in a player's game
- Whether it happens on a new run

## Feature requests

Open an issue using the **Feature request** template. Describe what you are trying to do, not how you think it should be built.

## Security issues

Do not open a public issue. See [SECURITY.md](.github/SECURITY.md).

## Changelog

`CHANGELOG.md` is load-bearing, not decoration. The release workflow extracts the section for the tag being released and publishes it verbatim as the release body, so:

- Every release needs a `## [x.y.z] - YYYY-MM-DD` section before it can be tagged
- Components are `### Server` and `### Client`, and nothing else
- Change types are `#### Added`, `#### Changed`, `#### Fixed`, `#### Removed`, in that order, and only the ones that apply
- Plain bullets. No bold lead-ins except a literal `**Breaking:**`, no emoji, no marketing language, no internal references

`tools/ci/lint-release-notes.sh` enforces all of it, and `.github/workflows/checks.yml` runs it on every push, so a bad section fails on the commit that wrote it, not on the tag that would have published it.

## Version numbers

The tag, the newest CHANGELOG heading and the version inside the release zip must all agree. `tools/ci/assert-version.sh` checks the first two and `tools/ci/verify-server-zip.sh` the zip. Run both locally before tagging:

```
tools/ci/assert-version.sh --tag v0.1.1
tools/ci/verify-server-zip.sh AccompliceServer-0.1.1.zip 0.1.1 checksums.txt
```

## Pull requests

This repo holds the documentation, the changelog and the release checks, not the mod's source code, so it takes pull requests for documentation and typo fixes only.

- One logical change per commit, short subject lines
- Run `tools/ci/assert-version.sh` and the changelog lint before opening the pull request

## Code of conduct

Be civil. Be technical. Do not post game-piracy or anti-cheat-evasion material in issues or pull requests.
