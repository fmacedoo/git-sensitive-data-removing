## git-sensitive-data-removing

A simple bash script to remove git files history which contains sensitive data like secrets, keys, passwords. Once you got here, you've failed on it like me. 😂

## Index
 - [Requirements](#requirements)
 - [Permissions](#permissions)
 - [Run](#run)
 - [The files collection file format](#the-files-collection-file-format)

## Requirements

- You must have git client installed.
- Windows users:
    - [GitBash] installed together with your git client.
- Unix based users:
    - Just run it at your terminal.

[GitBash]: <https://gitforwindows.org/>

## Pre-run

- Copy the script to the repository folder you want to get the script working.
- Grant execute permission (only for Unix)
```bash
$ chmod +x ./filter-repo
```

## Run

Run the script
```bash
$ ./filter-repo <files-collection-path>
```

## The files collection file format

Each line must provide a relative file path followed by the secrets which must be replaced, split by an empty space.

Format
```
<file-name> [secrets]
```

Example
```
conf/appsettings.json mysupersecuresecret
conf/config.js mysupersecuresecret anothersupersecuresecret
```