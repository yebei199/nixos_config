{ config, pkgs, lib, dankMaterialShell, niri, ... }:

{
  home.username = "yb";
  home.homeDirectory = "/home/yb";
  home.stateVersion = "25.05";

  # 引入 DankMaterialShell 和 Niri 的 Home Manager 模块
  imports = [
    dankMaterialShell.homeModules.dankMaterialShell.default
    dankMaterialShell.homeModules.dankMaterialShell.niri
    niri.homeModules.niri
  ];

  #programs.niri.enable = true;
  # 启用 DankMaterialShell
  programs.dankMaterialShell.enable = true;

  # 其他常用包
  home.packages = with pkgs; [
    fcitx5-configtool
    fastfetch
    bottom
    qq
    atuin
    starship
    zoxide
    bat
  ];
}

