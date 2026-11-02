# Changelog

All notable changes to Accomplice are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and Accomplice uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Each version is split into **Server** (AccompliceServer, the Accomplice mod running as a server) and **Client** (the Accomplice mod in a player's game, from the Steam Workshop). Both are the same mod, so they share one version number. A release publishes the section for its own version verbatim as the release body, so a version with no section here cannot be released.

## [Unreleased]

### Client

#### Fixed

- A long server name under Recent servers no longer runs past the edges of the Join window.

## [0.1.1] - 2026-11-01

The first Accomplice release: online co-op for Probably Stolen on a dedicated server. Every player needs the Accomplice mod from the Steam Workshop.

### Server

#### Added

- Runs Probably Stolen as a dedicated server on Windows. Players join by IP and port.
- 2 to 4 players run one shop together: one player works the counter while the others work the back room.
- Saves after every night. A player can join in the middle of a day.
- Join password, player limit, scenario, difficulty, Endless mode and voice chat, set in `server.json`.
- A status file, a commands file (`say`, `kick`, `save`, `newrun`) and a stop file for scripts and control panels.

### Client

#### Added

- Join server on the main menu, with your recent servers.
- Voice chat (hold V), text chat (T), pointing at items (G) and a crew report after each day.
- See where the other players are and what they are doing.
- The Join window says why a join was refused.
- Your single-player saves are never touched.
