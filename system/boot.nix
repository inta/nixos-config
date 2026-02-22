{ pkgs, ... }:

{
    # Bootloader.
    boot.loader = {
        systemd-boot.enable = true;
        systemd-boot.consoleMode = "keep"; # auto or max or keep
        efi.canTouchEfiVariables = true;
        timeout = 2;
    };

    # Use latest kernel.
    boot.kernelPackages = pkgs.linuxPackages_latest;

    # smaller font during boot
    # boot.kernelParams = [ "video=efifb:3840x2400" ];
    console.packages = with pkgs; [ terminus_font ];
    console.font = "ter-v24n";

    # boot splash
    boot.kernelParams = [
        "quiet"
        "splash"
        "video=efifb:3840x2400"
    ];
    boot.plymouth.enable = true;
    boot.plymouth.theme = "bgrt";
}
