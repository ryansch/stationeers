# Stationeers Dedicated Server [![](https://images.microbadger.com/badges/image/dtandersen/stationeers.svg)](https://microbadger.com/images/dtandersen/stationeers "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/dtandersen/stationeers.svg)](https://hub.docker.com/r/dtandersen/stationeers/) [![Docker Stars](https://img.shields.io/docker/stars/dtandersen/stationeers.svg)](https://hub.docker.com/r/dtandersen/stationeers/)

Play [Stationeers](https://store.steampowered.com/app/544550/Stationeers/) with your friends!

## Usage

Start stationeers with the following:

```console
docker-compose up -d stationeers
```

View the logs:

```console
docker-compose logs stationeers
```

Stop the server:

```console
docker-compose stop stationeers
```

Restart the server:

```console
docker-compose restart stationeers
```

Destroy the server:

```console
docker-compose rm -s stationeers
```

## Configuration

Put `default.ini` in the root of the mounted volume. If no `default.ini` is found a default `default.ini` is used.

Example `default.ini`:

```INI
[SERVER]
SERVERNAME=Stationeers
GAMEPORT=27500
UPDATERPORT=27015
PASSWORD=
MAPNAME=Moon
DESCRIPTION=Stationeers
MAXPLAYER=10

[RCON]
RCONPASSWORD=stationeers
```

## Saves

Saves are stored in the `/saves` directory of the mounted volume. Saves will be lost if `-v /some/local/path:/var/opt/stationeers` wasn't used.

Start the server with the `-loadworld=<name of save>` option to load a save.

Specify the world type with `-worldtype=Mars|Moon|Europa`.

## Command Line Options

* `-clearallinterval=<time in seconds>` - How often to remove disconnected players ([0=never](https://steamcommunity.com/games/544550/announcements/detail/1692683865304626238), default=immediately)
* `-autosaveinterval=<time in seconds>` - How often to auto save the game (default=never)

Refer to the Unofficial Stationeers Wiki for more information about [command line options](https://stationeers-wiki.com/Dedicated_Server_Guide).

NOTE: `-batchmode`, `-nographics`, and `-autostart` are automatically set.

## Image Layout

Stationeers is installed to `/opt/stationeers`.

Saves and configuration are stored at `/var/opt/stationeers`.

```
/
|-- var
|   `-- opt
|      `-- stationeers
|          |-- default.ini
|          |-- saves
|          |   |-- mysave1
|              `-- mysave2
`-- opt
    `-- stationeers
```

## rcon

The command line rcon console ([stationeersrcon](https://github.com/matjam/stationeersrcon)) is available with: `docker-compose exec stationeers srcon <command>`

Example:

```console
$ docker-compose exec stationeers srcon status
GameVersion : 0.2.1879.8621
GameStatus : Loading
No Players
```

The "rcon console" is available at http://HOST:GAMEPORT. Remove `27500:27500` from `docker-compose.yml` to disable remote access to rcon.

The rcon password is set by `RCONPASSWORD` in `default.ini`. A random password is generated if `default.ini` doesn't exist when the server starts.
