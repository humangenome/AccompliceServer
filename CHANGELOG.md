# Changelog

All notable changes to Accomplice are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and Accomplice uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Each version is split into **Server** (AccompliceServer, the Accomplice mod running as a server) and **Client** (the Accomplice mod in a player's game, from the Steam Workshop). Both are the same mod, so they share one version number. A release publishes the section for its own version verbatim as the release body, so a version with no section here cannot be released.

## [Unreleased]

## [0.2.12] - 2026-11-09

### Server

#### Added

- The log names the items that differ when a player's shop doesn't match the server's after loading, and what differs in a player's bag after a night out.

#### Fixed

- Reload loops: a player whose game keeps loading a few items differently is reloaded at most once every 5 minutes, not after every action.
- Players loading a big save were kicked after 30 seconds. Loading players now get 2 minutes.

### Client

#### Changed

- Sends its item counts after loading, and its bag after a night out, for the server's log. 0.2.11 servers ignore them.
- Waits 2 minutes for the server while loading, instead of 30 seconds.

## [0.2.11] - 2026-11-08

### Server

#### Changed

- Players on Accomplice older than 0.2.11 are asked to restart Steam so it updates before they join (was 0.2.9).

#### Fixed

- A server that runs in another language than English (its language comes from an uploaded SaveFile.es3) no longer has customers refuse every labeled water. The game fixes six water names when it starts and compares each bottle's name in the current language with them; the server took them in English before it switched language. It now takes them in the language it runs and puts any water label written in another language (a run made in another language) into it.

### Client

#### Fixed

- Sending away the returning customer who opens a case at your counter no longer leaves the shop reloading for every player until the next morning. Only the server runs the case opening now, so every player sees the same items and gets the same Glass Shiv.
- A player whose game runs in another language than the server can use machine buttons (for example Print Small Bottle). The server compared the button's translated label with its own and turned the press away with "That control is not there any more."; the player's game now sends its language, and the label is only compared when both match.

## [0.2.10] - 2026-11-07

### Server

#### Changed

- Players on Accomplice older than 0.2.9 are turned away at join with a sentence telling them to restart Steam to get the Workshop update. A 0.2.8 player on the game's 1.0.0.12 update could not follow a night out and kept reloading.
- The server log's join line names the player's Accomplice version.

### Client

#### Fixed

- A shop that falls out of step during a deal asks the server to put it right on a PC that has been running for 25 days or more. Before, it never asked there.

## [0.2.9] - 2026-11-07

### Server

#### Fixed

- Runs on the game's 1.0.0.12 update (Steam build 26496118) as well as the previous one.

### Client

#### Fixed

- After the game's 1.0.0.12 update the day can end again and players can go out at night. Before, once anyone had opened the map, "I'm ready" flipped back and the sleeping bag did nothing (#1).
- A player whose game runs in another language no longer gets their shop reloaded during water deals.
- The game's new options, Move Bought Items to Inventory and Disable Pop Culture Characters, follow the server, so every player's shop stays the same.
- Putting the shotgun away keeps Lou, Eleanor and Serpico talking, as the game now does.

## [0.2.8] - 2026-11-06

### Server

#### Added

- More players bring more customers: each player beyond the first adds half the day's customers again, at most 6 more a day, from day 2 of a new run (day 14 with the intro on). The new `extraCustomersPerPlayer` setting changes the share or turns it off. It works when every player runs 0.2.8 or newer; on a day with extra customers, an older player is asked to update.

#### Changed

- If the player at the counter does nothing for 30 seconds while another player wants it, the counter frees up (it was 60 seconds).

### Client

#### Added

- The Server list shows which version each server runs.

#### Fixed

- Picking a backpack (or no backpack) at the shop door opens the map. Before, it reloaded the game, so nobody could go out at night.

## [0.2.7] - 2026-11-05

### Server

#### Fixed

- The server clears what the last phone call left behind before each morning, so players are no longer reloaded every morning after a call.

### Client

#### Added

- Players also get a Copy invite button in the pause menu and the mod's texts in Chinese and Russian.

## [0.2.6] - 2026-11-05

### Server

#### Changed

- The server log now shows why a player's shop reloaded and which items were out of place, and a move overtaken by the same player's earlier move gets its own notice.

## [0.2.5] - 2026-11-04

### Server

#### Changed

- A player whose copy of a mod is not the same as the server's now joins with a warning, instead of being turned away. A player missing one of the server's mods is still turned away, and so is any different copy when Players must have exactly these mods is on.

## [0.2.4] - 2026-11-04

### Client

#### Added

- The main menu now tells you when a new version of Accomplice is out, and when it's downloaded and needs a game restart.

## [0.2.3] - 2026-11-04

### Client

#### Changed

- Server list replaces Find a server. It's one bigger list with the servers you joined before at the top, and clicking a server joins it. Chinese names no longer go blank in the Join window.

## [0.2.2] - 2026-11-04

### Client

#### Changed

- Clearer server list and mods window. Find a server now shows where each server is and how many mods it runs. The mods window lists each mod with its status and the steps numbered one at a time.

## [0.2.1] - 2026-11-03

### Server

#### Added

- The server's mods are the set every player runs. A player missing one, or with another copy of it, is turned away with the list of mods they need.
- `mods` in server.json: each mod's Workshop id, so players get a button to its Workshop page.
- `modsMustMatch` in server.json: also turn away players who run mods the server does not. Off by default: those players join with a warning.
- Players on the game's Steam beta are turned away when the server runs a different build, with the steps to switch back. Any other build difference joins with a warning.

#### Changed

- A server that runs other mods asks players on 0.1.6 or older to update. Servers with no other mods still take them.
- When a player's shop keeps disagreeing with the server in the same way, the server stops reloading it after three tries and tells the player why. The server log names the part that differs.

### Client

#### Added

- Mods for this server: when a server turns you away over mods, a window lists them with a button to each mod's Workshop page, counts how many Steam has downloaded, and says how to turn them on.
- A warning when the server runs a different build of the game.

## [0.1.6] - 2026-11-02

### Server

#### Changed

- The server reports itself to the in-game server list at a new address. Servers on 0.1.5 keep being listed.

### Client

#### Changed

- Find a server reads the server list from a new address. Players on 0.1.5 still see the list.

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
