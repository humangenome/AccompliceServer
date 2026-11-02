# Status and commands

How a script or a control panel watches and runs an AccompliceServer: the status check on the game port, the files in the server's data folder (the `--br-data` folder), and the log lines that keep their wording. Back to the [README](../README.md).

**Status check.** Connect to the server's port over TCP and send the line `STATUS`. The server answers one line of JSON and closes the connection, even while the shop is loading. Anyone who can reach the port can ask, so the answer leaves out the data folder and the last save time, and on a server with a password it leaves out player names but still gives the number of players.

**Commands.** Add a line to `commands.txt` in the data folder. The server reads the file once a second, runs each line, empties the file and logs `[Accomplice] command: <line> -> <result>`. The commands are listed in the [README](../README.md#status-and-commands).

A line the server does not know logs `-> unknown command` and does nothing.

**Status file.** The server rewrites `status.json` in the data folder every 10 seconds, and whenever a player joins or leaves, the shop saves, the day changes or a run ends. It holds the server's state (loading, running, ended or stopping), its name, the players on (id and name), the player limit, the day, cash, scenario, the ending if the run ended, the time of the last save, the mod, protocol and game versions, and the data folder. It is written to `status.json.tmp` first and then swapped in, so a reader never sees half a file. It never leaves the machine.

**Stopping.** Create an empty file named `stop` in the data folder. The server notices within a second, saves if nobody has opened the shop today, closes the port, removes the file and exits within a few seconds. The game saves only between days: if a day is in progress, the shop goes back to that morning's save on the next start. Ending the process by force does the same.

**Log lines.** The server's log is the `-logFile` path, and the mod's lines start with `[Accomplice]`. These lines keep their wording from release to release, so a script can watch for them:

| Line | Means |
|---|---|
| `[Accomplice] server: listening on TCP <port>` | Players can connect |
| `[Accomplice] server: could not listen on TCP <port>` | Another program has the port; the server stops |
| `[Accomplice] server: could not open the save` | The save would not load; the server stops |
| `[Accomplice] server: run ended (<ending>)` | The run ended |
| `[Accomplice] server: new run started (<scenario>)` | A new run began |
| `[Accomplice] command: <line> -> <result>` | One per `commands.txt` line |
