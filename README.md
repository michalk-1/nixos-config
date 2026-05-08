# NixOS and nix-darwin Configurations for My Machines

## Building and Applying Configurations

1. Commit new files to git:

```sh
git add --a
```

2. Build and switch to the new system configuration:

```sh
sudo -H nix run nix-darwin -- switch --flake .
```

or

```sh
sudo -H darwin-rebuild switch --flake .
```

## Updating Flakes

To update all flake inputs to their latest versions:

```sh
nix flake update --commit-lock-file
```
