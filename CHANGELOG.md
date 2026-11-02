# Changelog

All notable changes to Accomplice are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and Accomplice uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Each version is split into **Server** (AccompliceServer, the Accomplice mod running as a server) and **Client** (the Accomplice mod in a player's game, from the Steam Workshop). Both are the same mod, so they share one version number. A release publishes the section for its own version verbatim as the release body, so a version with no section here cannot be released.

## [Unreleased]

## [0.1.5] - 2026-11-02

### Server

#### Added

- The server shows up in the in-game server list by itself, with its name, players and day, for as long as it answers.
- Joining players get the list of mods the server runs.

#### Changed

- At most 4 players.

### Client

#### Added

- Find a server: a list of public Accomplice servers in the Join window. Servers on another version are shown dimmed, with what to update.
- A warning when you join with mods the server doesn't run.

#### Fixed

- Long server names fit the Recent servers list.

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
