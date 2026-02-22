{ pkgs, ... }:

{
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 2;
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
