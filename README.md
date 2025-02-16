# WIP NixOS configuration

[![xc compatible](https://xcfile.dev/badge.svg)](https://xcfile.dev)

This uses a pattern I used with Puppet to manage servers previously. Third party modules are configured in the `site` module, which then get collected into the `roles` module, with the `profile` module providing host specific configuration.

Systems are set up using a modified [genNixOSHosts](https://github.com/arnarg/config/blob/3ea96e9c1df0251add95404c64644d3411733ffb/lib/default.nix) from the `hosts` folder.

## Tasks

### build

Only build by default, noop/repl/test/switch/boot with argument

Inputs: COMMAND, CONFIG
Environment: COMMAND=build, CONFIG=

```bash
ARGS=""
if [[ $COMMAND = "noop" || $COMMAND = "dry-activate" ]]; then
    xc notify "nix: dev build" "completed build, prompting for password"
    nixos-rebuild --sudo dry-activate --flake .#$CONFIG $ARGS
elif [[ $COMMAND = "noop-build" || $COMMAND = "dry-build" ]]; then
    nixos-rebuild --sudo dry-build --flake .#$CONFIG $ARGS
elif [[ $COMMAND = "repl" ]]; then
    nixos-rebuild repl --flake .#$CONFIG $ARGS
else
    nh os $COMMAND -- $ARGS
fi

if [[ $COMMAND != "repl" ]]; then
    xc notify "nix: build" "completed $COMMAND"
fi
```

### dev

Override my modules to local paths

Only build by default, noop/repl/test/switch/boot with argument

Inputs: COMMAND, CONFIG
Environment: COMMAND=build, CONFIG=

```bash
ARGS="--no-write-lock-file --option warn-dirty false --override-input ozzie-lab ../lab --override-input ozzie-secrets ../secrets --override-input ozzie-workstation ../workstation"
if [[ $COMMAND = "noop" || $COMMAND = "dry-activate" ]]; then
    nixos-rebuild --sudo dry-activate --flake .#$CONFIG $ARGS
elif [[ $COMMAND = "noop-build" || $COMMAND = "dry-build" ]]; then
    nixos-rebuild --sudo dry-build --flake .#$CONFIG $ARGS
elif [[ $COMMAND = "repl" ]]; then
    nixos-rebuild repl --flake .#$CONFIG $ARGS
else
    nh os $COMMAND -- $ARGS
fi

if [[ $COMMAND != "repl" ]]; then
    xc notify "nix: build" "completed $COMMAND"
fi
```

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

### deploy

Deploy configuration to remote target

Only build by default, test/switch/boot with argument

Inputs: CONFIG, COMMAND, TARGET_HOST
Environment: COMMAND=build, TARGET_HOST=

```bash
if [ -z "${TARGET_HOST}" ]; then
    TARGET_HOST=$CONFIG
fi

nixos-rebuild $COMMAND --use-remote-sudo --target-host $TARGET_HOST --flake .#$CONFIG
xc notify "nix: deploy on $TARGET_HOST" "completed $COMMAND"
```

### deploy-hosts

Deploys all known hosts, or provided list

Inputs: HOSTS, COMMAND
Environment: HOSTS=, COMMAND=build, NIX_SSHOPTS=-t

```bash
if [ -z "${HOSTS}" ]; then
    HOSTS=$(ls -1 hosts/)
fi

for host in $HOSTS; do
    xc deploy $host $COMMAND
done
```

### test

Used to validate flake, builds all known hosts, or provided list

Inputs: HOSTS, NCPS_URL
Environment: HOSTS=, NCPS_URL=

```bash
if [[ -z "${HOSTS}" ]]; then
    HOSTS=$(nix flake show --json | jq -r '. | select(.nixosConfigurations != null) | .nixosConfigurations | keys[]')
fi

BUILDS=
for host in $HOSTS; do
    BUILDS+=".#nixosConfigurations.${host}.config.system.build.toplevel "
done

OUTPUTS=$(nix build $BUILDS --json | jq -r '.[].outputs.out')

if [[ -n $OUTPUTS ]] && [[ -n $NCPS_URL ]]; then
    nix copy --to "${NCPS_URL}" $OUTPUTS
fi

nix build .#isoConfigurations.installer-minimal.config.system.build.toplevel
nix build .#deprecatedConfigurations.gnome.config.system.build.toplevel
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

### generations

Show system generations

```bash
nixos-rebuild list-generations
```

### iso

Create installation ISO, or download from https://github.com/nix-community/nixos-images/releases

Inputs: CONFIG
Environment: CONFIG=installer-minimal

```bash
nom build .#isoConfigurations.${CONFIG}.config.system.build.isoImage
xc notify "nix: iso" "created $CONFIG"
```

### install

Install through nixos-anywhere

Inputs: CONFIG, HOST
Environment: HOST=

```bash
if [ -z "${HOST}" ]; then
    HOST=$CONFIG
fi

nix run github:nix-community/nixos-anywhere -- --flake .#$CONFIG $HOST
xc notify "nix: install on $HOST" "completed"
```

### reinstall

Same as install, but only tell disko to remount rather then reinit

Inputs: CONFIG, HOST
Environment: HOST=

```bash
if [ -z "${HOST}" ]; then
    HOST=$CONFIG
fi

nix run github:nix-community/nixos-anywhere -- --flake .#$CONFIG $HOST --disko-mode mount
xc notify "nix: reinstall on $HOST" "complete"
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
