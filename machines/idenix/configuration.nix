{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/boot.nix
    ../../system/locale.nix
    ../../system/home-manager.nix
    ../../system/desktop.nix
    ../../system/audio.nix
    ../../system/docker.nix
    ../../users/cs
  ];

  security.sudo.enable = false;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 7d";

  networking.hostName = "idenix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # # Enable networking
  # networking.networkmanager.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.cs = {
  #   isNormalUser = true;
  #   description = "Christoph";
  #   extraGroups = [ "networkmanager" "wheel" ];
  #   packages = with pkgs; [
  #   #  thunderbird
  #   ];
  # };

  # Install firefox.
  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    # git
    helix
    neovim
    dnsutils
    pciutils
    usbutils
  ];

  environment.variables.EDITOR = "nvim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?
}
