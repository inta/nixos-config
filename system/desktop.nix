{ pkgs, ... }:

{
  services.xserver.enable = false;

  # make sure to enable only one login manager
  services.displayManager.gdm.enable = true;
  # services.displayManager.cosmic-greeter.enable = true;

  services.desktopManager.gnome.enable = true;
  environment.systemPackages = with pkgs.gnomeExtensions; [
    caffeine
    docker
    quake-terminal
  ];

  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-store
  ];

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
