# NixOS configuration

This uses a pattern I used with Puppet to manage servers previously. Third party modules are configured in the `site` module, which then get collected into the `roles` module, with the `profile` module providing host specific configuration.

Systems are set up using a modified [genNixOSHosts](https://github.com/arnarg/config/blob/3ea96e9c1df0251add95404c64644d3411733ffb/lib/default.nix) from the `hosts` folder.

## Tasks

### installer

Create installation ISO

```
nix build .#isoConfigurations.installer.config.system.build.isoImage
```

### switch

Generate and switch

```
nh os switch
```
