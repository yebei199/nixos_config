{ config, pkgs, ...}:
{
    imports = [
        ./hardware-configuration.nix
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  services.displayManager.sddm.enable = true;
  services.xserver = {
        enable = true;
    };

programs.zsh.enable = true;
programs.fish.enable = true;
users.defaultUserShell = pkgs.fish;

users.users.yb = {
  isNormalUser = true;        # 普通用户
  extraGroups = [ "wheel" "uucp" "input" "docker" ];  # 可选：让 yb 有 sudo 权限
  group = "yb";               # 主组
};

users.groups.yb = {};          # 定义一个同名用户组
services.blueman.enable = true;   # 启用 Blueman
hardware.bluetooth.enable = true; # 启用 BlueZ

nixpkgs.config.allowUnfree = true;

programs.niri.enable = true;
programs.xwayland.enable = true;

i18n.inputMethod = {
  enable = true;
  type = "fcitx5";
  fcitx5.addons = with pkgs; [
    fcitx5-rime
    fcitx5-gtk
    kdePackages.fcitx5-qt
    fcitx5-chinese-addons
  ];
};



  environment.systemPackages = with pkgs; [
    go
    #google-chrome
    chromium
    quickshell
    home-manager
    xray
    xremap
    gtk3
    gtk4
    xorg.xinit
    xwayland-satellite
    qq
    feishu
    v2rayn
    waybar
    vim
    alacritty
    yazi
    git
    chezmoi
    ghostty
    neovim
    fuzzel
  ];

environment.variables = {
  GOPROXY = "https://goproxy.cn,direct";
  HTTP_PROXY = "http://127.0.0.1:7897";
  HTTPS_PROXY = "http://127.0.0.1:7897";
};


  nix = {
  package = pkgs.nix;

  settings ={
      sandbox = false;

	experimental-features = ["nix-command" "flakes"];
	substituters = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.ustc.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"
  ];

  };

  };
  system.stateVersion = "25.05";
}

