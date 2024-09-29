# WIP NixOS configuration

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

This uses a pattern I used with Puppet to manage servers previously. Third party modules are configured in the `site` module, which then get collected into the `roles` module, with the `profile` module providing host specific configuration.

Systems are set up using a modified [genNixOSHosts](https://github.com/arnarg/config/blob/3ea96e9c1df0251add95404c64644d3411733ffb/lib/default.nix) from the `hosts` folder.

## Tasks

### lock

Lock flake inputs

```bash
nix flake lock
```

### update

Update all/specific flake

Inputs: MODULE
Environment: MODULE=

```bash
nix flake update $MODULE
```

### update-mine

Update my flake locks

```bash
nix flake update ozzie-lab ozzie-secrets ozzie-workstation
```

### check

Check flake outputs

```bash
nix flake check
```

### inputs

Check flake inputs

```bash
nix flake metadata
```

### test

Validate flake

```bash
nix flake check
```

### try

Try a package in the shell

Inputs: PACKAGE

```bash
nix shell nixpkgs#$PACKAGE
```

### run

Run a package in the shell

Inputs: PACKAGE

```bash
nix run nixpkgs#$PACKAGE
```

### repl

Open repl for specified flake

Inputs: MODULE
Environment: MODULE=

```bash
if [[ -z $MODULE ]]; then
    nix repl --expr "builtins.getFlake ''$PWD''"
elif [[ -d "$PWD/../$MODULE" ]]; then
    nix repl --expr "builtins.getFlake ''$PWD/../$MODULE''"
else
    echo Module not found: $(realpath $PWD/../$MODULE)
fi
```

### notify

Try to send a notification

Inputs: TITLE, MESSAGE
Environment: MESSAGE=

```bash
if command -v kitten >/dev/null 2>&1; then
    kitten notify "$TITLE" "$MESSAGE"
elif command -v notify-send >/dev/null 2>&1; then
    notify-send "$TITLE" "$MESSAGE"
fi
```
