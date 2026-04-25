# Nixos config with flakes

## Update local state

```sh
nix flake update
```

## Build generation for the next boot

```sh
nixos-rebuild boot --flake
```

## Build generation and use it immediately

```sh
nixos-rebuild switch --flake
```

## Build local for remote target

```sh
nixos-rebuild switch --flake .#immich --target-host root@immich.lan.internal
```

## Build on the remote target

```sh
nixos-rebuild switch --flake .#immich --target-host root@immich.lan.internal --build-host root@immich.lan.internal
```
