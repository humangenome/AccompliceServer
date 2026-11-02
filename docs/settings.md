# Settings

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

## Saves and backups

Everything about the shop is in its data folder: the save (`save_<slot>.es3`), `saves_index.es3`, the game's daily copies (`save_<slot>_day<N>_<date>.es3`), the server's day log (`daylog.jsonl`), `status.json` and `commands.txt`. Copy that folder while the server is stopped to back it up, and put the files back the same way to restore.

The server saves after every night. When a run ends in a loss, its save is renamed `ended_<date>_save_<slot>.es3` so it never loads again. A buyout ending keeps the run going.

Players' own saves are never touched: on each player's PC, the server's shop goes into a separate save that only Accomplice uses.

Commands, the status file and the stop file: [status-and-commands.md](status-and-commands.md).
