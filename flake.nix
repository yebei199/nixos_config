{
description = "My NixOS configuration";

inputs = {
  
  nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable/nixexprs.tar.xz";

  niri.url = "github:sodiboo/niri-flake";
  niri.inputs.nixpkgs.follows = "nixpkgs";

  dankMaterialShell.url = "github:AvengeMedia/DankMaterialShell";
  dankMaterialShell.inputs.nixpkgs.follows = "nixpkgs";

  home-manager.url = "github:nix-community/home-manager";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = { self, nixpkgs, home-manager, dankMaterialShell, niri, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    lib = pkgs.lib;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
  system = system;
  modules = [
    ./configuration.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      # 把第三方 flake 通过 extraSpecialArgs 传进 home.nix
          home-manager.extraSpecialArgs = {
		inherit dankMaterialShell niri;
            # 如果你引入了 niri flake，也可以传入：inherit niri;
          };
      home-manager.users.yb = import ./home.nix;

    }
  ];
};


  };
}
