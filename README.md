<p align="center">
  <a href="#requirements"><img src="https://img.shields.io/badge/Platform-Windows_10%2F11%2FServer-blue.svg" alt="Platform"></a>
  <a href="https://store.steampowered.com/app/4348910/"><img src="https://img.shields.io/badge/Game-Probably_Stolen-d6336c.svg" alt="Game"></a>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=3832445441"><img src="https://img.shields.io/badge/Player_Mod-Steam_Workshop-brightgreen.svg" alt="Player mod"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License"></a>
</p>

# AccompliceServer

[Probably Stolen](https://store.steampowered.com/app/4348910/) has no multiplayer and no dedicated server. Accomplice adds online co-op through a Probably Stolen dedicated server: AccompliceServer runs the game headless on a Windows machine with a public IP and port, and 2 to 4 players join it from the game's own main menu.

Every player needs the [Accomplice mod from the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3832445441) to join. Stock Probably Stolen cannot connect to an Accomplice server. This repo is for the person running the server; players only need the mod.

## Rent a server

If you would rather not run the machine, [SurvivalServers.com](https://www.survivalservers.com/services/game_servers/probably_stolen/?utm_source=github&utm_medium=readme_install&utm_campaign=accomplice) runs Probably Stolen servers with Accomplice already installed and the port already open.

## What it does

- Runs one shop for 2 to 4 players: every player's game shows the same stock, customers and cash
- Gives the counter to one player at a time: that player calls the customer, talks, haggles and appraises while the others work the back room, and the counter passes on when they are done, leave, or do nothing for 60 seconds
- Starts the night when every player is ready, or a set time after the first one is
- Takes the whole shop on nights out together
- Lets a player join in the middle of a day, straight into the day where the group is
- Voice and text chat for the whole shop, with a setting to turn voice off for everyone
- Password protection, and a player limit you set (4 by default)
- Starts a new run in any of the game's nine playable scenarios and four difficulties, with Endless mode if you want it
- When the shop goes under, shows every player the ending, keeps the lost run under a new name, and starts a new run once every player votes for one
- Writes a status file and reads a commands file, so a panel or a script can see who is on and send chat, kick, save or start a new run without a login
- Answers a status check on its game port (name, players, day, versions, password)

## What it does not do

- **It does not ship Probably Stolen.** The release zip holds only the mod. You install the game on the server machine with Steam, from your own copy of it.
- **It does not replace the player's game.** Everyone joining runs their own Probably Stolen with Accomplice turned on.
- **It cannot be hosted from a player's game.** There is no Host button: a shop runs only on an Accomplice server.
- **It is not an anti-cheat.** Accomplice does not police what players do in their own game.

## Requirements

| | |
|---|---|
| OS | Windows 10, Windows 11, or Windows Server |
| Game | Probably Stolen installed with Steam on the machine, and the Steam client running and signed in to an account that owns the game while the server runs |
| Port | One TCP port per server (default `27700`), open in Windows Firewall and in any firewall in front of the machine, and forwarded if the machine sits behind NAT |
| Network | A public IP address that players can reach |
| Hardware | No graphics card needed: the server starts the game with `-nographics`. In our lab, a server with two players on it used about 800 MB of RAM and under 2% of one CPU core |

## Setup

1. Install Probably Stolen with Steam on the machine.
2. Download `AccompliceServer-<version>.zip` from the [latest release](https://github.com/HumanGenome/AccompliceServer/releases/latest) and unpack it **into** the game folder (the folder with `Probably Stolen.exe`), so the mod lands in `Mods\Accomplice\`.
3. Turn the mod on once. As the Windows user that will run the server, start the game normally, click Mods, select Accomplice and click Activate, approve the three permissions it asks for (internet access, files and Steam features), then quit. The server reads the same list of active mods.
4. Make a folder for the shop, for example `C:\Shop1`, holding a `server.json` ([Settings](#settings)) and an empty `data` folder for its saves.
5. Start the server from the game folder, in a Command Prompt:

   ```bat
   "Probably Stolen.exe" -batchmode -nographics -logFile "C:\Shop1\player.log" ^
     --br-server --br-config="C:\Shop1\server.json" --br-data="C:\Shop1\data"
   ```

   The log says `[Accomplice] server: listening on TCP 27700` once players can join.
6. Allow the server's TCP port through Windows Firewall and any firewall in front of the machine.
7. Players join from the game's main menu: Join server, then the server's address as `ip:port` (for example `203.0.113.24:27700`) and the password if you set one. The game keeps the server under Recent servers for next time.

Running two shops on one machine: start one server per shop, each with its own `server.json`, port and data folder.

If a player cannot join, the Join window says why: a wrong password, a full server, a server still starting, a mod or game version that does not match the server's, or a server it could not reach. The last one means the server is not running or the port is closed.

## Settings

The server reads the `server.json` named by `--br-config`. This example holds every key at its default. A key you leave out takes its default, and unknown keys are ignored.

```json
{
  "port": 27700,
  "name": "My shop",
  "password": "",
  "maxPlayers": 4,
  "saveSlot": 1,
  "newRun": {
    "scenario": "WATER_MERCHANT",
    "difficulty": "normal",
    "skipIntro": true
  },
  "endless": false,
  "readyTimeoutSeconds": 120,
  "frameRate": 10,
  "voice": true
}
```

| Key | Meaning |
|---|---|
| `port` | The TCP port for players and the status check |
| `name` | The name players see when they join (64 characters at most) |
| `password` | Join password; empty means open |
| `maxPlayers` | Most players at once (1 to 4) |
| `saveSlot` | Which save in the data folder is the shop |
| `newRun.scenario` | The scenario for a new run (list below) |
| `newRun.difficulty` | The difficulty for a new run (list below) |
| `newRun.skipIntro` | Skips the game's intro in a new run |
| `endless` | The game's Endless mode, for a new run |
| `readyTimeoutSeconds` | How long the server waits after the first player is ready before it starts the night, or after the first vote for a new run |
| `frameRate` | The server's frames per second (1 to 60) |
| `voice` | Voice chat on this server; `false` turns it off for every player |

`newRun` and `endless` are used when the save in `saveSlot` does not exist yet and whenever a new run starts. The server reads them from the file again at that moment, so you can change them while it runs.

Scenarios: `APPRENTICE`, `WATER_MERCHANT`, `FENCE`, `ROCK_BOTTOM`, `FARMER` (Hydroponic Farmer), `GUNSMITH`, `DRUG_DEALER` (Chemist), `RANCHER`, `AQUAFARMER`. These nine are the only ones the server starts: the game's other scenarios are marked coming soon and the server refuses them.

Difficulties: `cozy` (Price Gouge), `normal` (Mark Up), `hard` (Thin Margins), `challenge` (Red Ink).

## Status and commands

The server answers a `STATUS` line on its game port with one line of JSON (name, players, day, versions, password), and anyone who can reach the port can ask. In its data folder it rewrites `status.json` every 10 seconds, runs each line it finds in `commands.txt`, and shuts down cleanly when a file named `stop` appears.

| Command | Does |
|---|---|
| `say <text>` | Shows a server message in every player's chat (200 characters at most) |
| `kick <id or name>` | Removes that player now. They can join again: change the password to keep someone out |
| `save` | Saves at the next safe point |
| `newrun` | Starts a new run, only after a run has ended |
| `newrun force` | Starts a new run now, whatever the state of the current one |

What each file holds, how stopping treats a day in progress, and the log lines a script can watch for: [docs/status-and-commands.md](docs/status-and-commands.md).

## Saves and backups

Everything about the shop is in its data folder: the save (`save_<slot>.es3`), `saves_index.es3`, the game's daily copies (`save_<slot>_day<N>_<date>.es3`), the server's day log (`daylog.jsonl`), `status.json` and `commands.txt`. Copy that folder while the server is stopped to back it up, and put the files back the same way to restore.

The server saves after every night. When a run ends in a loss, its save is renamed `ended_<date>_save_<slot>.es3` so it never loads again. A buyout ending keeps the run going.

Players' own saves are never touched: on each player's PC, the server's shop goes into a separate save that only Accomplice uses.

## Server list

From version 0.1.4, every Accomplice server appears in the in-game server list automatically, with its address, name, player count and day. The address is public: anyone who opens the list can see it and connect, so set a password if the shop is only for your group. A server with a password shows a lock, and the list never shows player names. Servers on another mod or game version are listed too, dimmed, with the update a player would need. The server tells the list its port once a minute; the list, run by SurvivalServers.com, takes the address from the connection itself and shows a server only while it answers the status check. There is no setting to leave a server off the list.

## Releases

Each release attaches `AccompliceServer-<version>.zip` and `checksums.txt` (its SHA-256). The zip holds the mod (the same `Accomplice.dll` players get from the Workshop), its manifest, a README, the third-party notices and `accomplice-server.json`, which lists every other file with its size and SHA-256. To check a download on Windows, compare `Get-FileHash AccompliceServer-<version>.zip` with the line in `checksums.txt`.

A player can join when their mod speaks the same network protocol as the server and their game is on the same version; the Join window tells anyone else whether to update the mod or the game. Steam updates players' mods by itself, so update the server when a release comes out. The changelog for both sides is [CHANGELOG.md](CHANGELOG.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Security issues go through [private reporting](.github/SECURITY.md), never a public issue.

## Community note

Accomplice is an independent community project. It is not affiliated with, endorsed by, or supported by Questing Goose Studio or by tinyBuild, the game's publisher.

## License

MIT, see [LICENSE](LICENSE). Every release zip also carries `THIRD-PARTY-NOTICES.txt`: the BSD licence of Concentus, the voice codec built into the mod, which must travel with every copy of it.
