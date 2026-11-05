<p align="center">
  <a href="#host-your-own"><img src="https://img.shields.io/badge/Platform-Windows_10%2F11%2FServer-blue.svg" alt="Platform"></a>
  <a href="https://store.steampowered.com/app/4348910/"><img src="https://img.shields.io/badge/Game-Probably_Stolen-d6336c.svg" alt="Game"></a>
  <a href="https://steamcommunity.com/sharedfiles/filedetails/?id=3832445441"><img src="https://img.shields.io/badge/Player_Mod-Steam_Workshop-brightgreen.svg" alt="Player mod"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="License"></a>
</p>

# AccompliceServer

[Probably Stolen](https://store.steampowered.com/app/4348910/) has no multiplayer. Accomplice adds online co-op: 2 to 4 friends run one shop together on a Probably Stolen dedicated server. This repo is that server.

![How it plays: friends join your shop, one works the counter, the rest help out back, talk on voice or chat, ready up for the night](docs/images/how-it-plays.jpg)

<p>
  <img src="docs/images/haggle-together.jpg" width="49%" alt="Theo haggles with a merchant while Mara's chat lines show in the corner">
  <img src="docs/images/crew-report.jpg" width="49%" alt="The crew report after day 1: what Theo and Mara each did">
  <img src="docs/images/nights-out.jpg" width="49%" alt="A night out at Dr. Jackson's: the player list shows who is haggling">
  <img src="docs/images/play-with-your-mods.jpg" width="49%" alt="The Mods for this server window lists a missing mod with its Workshop page button">
</p>

## Rent a server

[SurvivalServers.com](https://www.survivalservers.com/services/game_servers/probably_stolen/?utm_source=github&utm_medium=readme_install&utm_campaign=accomplice) runs Probably Stolen servers with Accomplice installed and ready to join.

## How to join

Every player needs their own copy of Probably Stolen.

1. Subscribe to [Accomplice on the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3832445441).
2. Start the game, click **Mods**, select **Accomplice**, click **Activate**, then **Yes**. Restart the game.

   ![The game's Mods window with Accomplice selected](docs/images/mods-activate.png)

3. Click **Join server** on the main menu, then **Server list**, and click a server to join it. Or type the server's address and password and click **Join**.

   <img src="docs/images/join-server.png" width="440" alt="The Join server window">

## Host your own

You need a Windows PC that players can reach (a public IP and one open TCP port, 27700 by default) with Probably Stolen installed and Steam signed in.

1. Download `AccompliceServer-<version>.zip` from [Releases](https://github.com/HumanGenome/AccompliceServer/releases/latest) and unzip it into the game folder (the one with `Probably Stolen.exe`).
2. Start the game once, turn on Accomplice in **Mods** as above, then quit.
3. Make a folder for the shop, for example `C:\Shop1`, holding a `server.json` and an empty `data` folder:

   ```json
   { "port": 27700, "name": "My shop", "password": "", "maxPlayers": 4 }
   ```

4. Start the server from the game folder:

   ```
   "Probably Stolen.exe" -batchmode -nographics -logFile "C:\Shop1\player.log" ^
     --br-server --br-config="C:\Shop1\server.json" --br-data="C:\Shop1\data"
   ```

5. Allow the port through Windows Firewall, and forward it on your router if the PC is behind one. Players join with your public IP and the port.

Scenario, difficulty, voice chat, saves and backups: [docs/settings.md](docs/settings.md). Commands and status: [docs/status-and-commands.md](docs/status-and-commands.md).

## Server list

Every Accomplice server shows up in the in-game server list by itself, with its name, players and day, and players click a server to join it. The address is public, so set a password if the shop is only for your group: password servers show a lock, and the list never shows player names. Servers on another version are listed too, dimmed.

![The in-game Server list](docs/images/server-list.png)

## Updating

Download the new zip from [Releases](https://github.com/HumanGenome/AccompliceServer/releases/latest) and unzip it over the old files. Players' copies of the mod update through Steam and don't have to match the server's version exactly; when one can't join, the Join window says what to update.

When Probably Stolen itself updates, update the game on the server PC too: players and the server need the same game version.

## License

[MIT](LICENSE). Accomplice is a free, unofficial mod, not made by or affiliated with Questing Goose Studio or tinyBuild.
