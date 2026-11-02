# Changelog

All notable changes to Accomplice are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and Accomplice uses [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Each version is split into **Server** (AccompliceServer, the Accomplice mod running as a server) and **Client** (the Accomplice mod in a player's game, from the Steam Workshop). Both are the same mod, so they share one version number. A release publishes the section for its own version verbatim as the release body, so a version with no section here cannot be released.

## [Unreleased]

### Client

#### Fixed

- A long server name under Recent servers no longer runs past the edges of the Join window.

## [0.1.1] - 2026-11-01

The first Accomplice release: online co-op for Probably Stolen, played on a dedicated server. Every player in the group needs the Accomplice mod from the Steam Workshop; stock Probably Stolen cannot connect to an Accomplice server.

### Server

#### Added

- Runs Probably Stolen as a dedicated server on Windows, headless. Players join it by IP and port from the game's main menu.
- One shop for 2 to 4 players: the server holds the run, and every player's game shows the same stock, customers and cash.
- One player at a time holds the counter (calling the customer, talking, haggling, appraising) while the others work the back room. The counter passes on when that player is done, leaves, or does nothing for 60 seconds.
- Anyone can open the shutter. After closing, the night starts when every player is ready, or a set time after the first one is, and the server saves after every night. Nights out are a group trip.
- A player can join in the middle of a day and loads into the day where the group is.
- When a run ends in a loss, every player sees the ending, the lost run is kept under a new name, and a new run starts when every player votes for one.
- A join password, a player limit (1 to 4), the scenario and difficulty for a new run (nine playable scenarios, four difficulties), Endless mode and voice on or off, all set in `server.json`.
- A status file the server writes, a commands file it reads (`say`, `kick`, `save`, `newrun`) and a stop file, so a script or a control panel can see who is on and run the server.
- The server answers a status check on its game port with its name, players, day and versions, and leaves out player names when it has a password.

### Client

#### Added

- Join server on the main menu: type the server's address and the password if there is one. The game keeps the server under Recent servers.
- Every player sees the others' cursors and names, and who is at the counter, on the phone or aiming the shotgun.
- Hold V to talk to everyone in the shop, and press T for text chat. Any player can be muted in Options.
- While one player haggles, the others can check the customer's goods with the magnifier, scanners and test strips.
- Press G to point at an item or a spot: everyone sees the marker and a chat line saying what you pointed at.
- When a player picks up an item, everyone sees it next to that player's cursor.
- A crew report at the end of each day shows each player's customers served, items sold and bought, money in and out, repairs, machine work, items made and stolen goods caught.
- The Join window says why a join was refused: a wrong password, a full server, a server still starting, or a mod or game version that does not match the server's.
- The server's shop is kept in its own save, apart from your single-player runs. With the mod turned off, the game plays as before.
- Made for the game's Modding Security Update (1.0.0.6): the game asks for three permissions when you activate the mod, internet access, files and Steam features (to show your Steam name to the other players).
