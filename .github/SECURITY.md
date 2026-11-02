# Security Policy

## Reporting a vulnerability

If you have found a security issue in AccompliceServer or the Accomplice mod, please **do not** open a public GitHub issue.

Report it privately through GitHub's security advisory form: https://github.com/HumanGenome/AccompliceServer/security/advisories/new

**There is no security mailing address.** The advisory form above is the only reporting channel; an email address claiming to be ours is not one.

Include:

- A description of the vulnerability
- Steps to reproduce
- Affected side (server / player's game / configuration)
- Accomplice version (the release tag, e.g. `v0.1.1`)
- Whether the issue is currently being exploited

Reports are acknowledged within 72 hours and triaged within 7 days.

## Scope

In scope:

- Remote code execution or unauthenticated takeover of the server process
- A connected player being able to read or write arbitrary files on the host
- A server being able to read or write files on a player's PC outside the shop's own save, or run code there
- Admission bypass: joining without the password, or impersonating another player or the server
- Privilege escalation out of the game process the server runs
- Path traversal through server names, player names, save paths, or configuration values
- Command injection through any value the server reads from configuration or from the network

Out of scope:

- Vulnerabilities in the machine your server runs on: those belong to whoever operates it
- Vulnerabilities in retail Probably Stolen itself: report those to the game's developer
- Vulnerabilities in other mods running alongside Accomplice
- Cheating and anti-cheat concerns; Accomplice does not provide anti-cheat
- Denial of service by simply sending a server more traffic than its link can carry
- Anything requiring administrative access to the host, which already implies full control

## Supported versions

Only the latest released version receives security fixes. Accomplice is pre-1.0 and moves fast; there is no long-term support branch.
