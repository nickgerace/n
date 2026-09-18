{
  description = "NixOS configuration for a Lima guest";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-lima = {
      url = "github:nixos-lima/nixos-lima";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixos-lima,
    ...
  }: {
    nixosConfigurations.lima = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs.pkgsUnstable = import nixpkgs-unstable {
        system = "aarch64-linux";
        config.allowUnfreePredicate = pkg:
          nixpkgs.lib.getName pkg == "claude-code";
      };
      modules = [
        nixos-lima.nixosModules.lima
        ({
          lib,
          modulesPath,
          pkgs,
          pkgsUnstable,
          ...
        }: {
          # The profile has "qemu" in its name, but this is for apple-native "vz".
          imports = [(modulesPath + "/profiles/qemu-guest.nix")];

          services.lima.enable = true;
          services.openssh.enable = true;
          security.sudo.wheelNeedsPassword = false;
          users.mutableUsers = true;

          nix.settings.experimental-features = [
            "nix-command"
            "flakes"
          ];
          nixpkgs.config.allowUnfreePredicate = pkg:
            lib.getName pkg == "claude-code";

          boot.loader.grub = {
            configurationLimit = 2;
            device = "nodev";
            efiSupport = true;
            efiInstallAsRemovable = true;
          };

          fileSystems."/boot" = {
            device = lib.mkForce "/dev/vda1";
            fsType = "vfat";
          };

          fileSystems."/" = {
            device = "/dev/disk/by-label/nixos";
            autoResize = true;
            fsType = "ext4";
            options = [
              "noatime"
              "nodiratime"
              "discard"
            ];
          };

          environment.systemPackages = with pkgsUnstable; [
            bash
            cargo
            clang
            claude-code
            codex
            curl
            git
            helix
            htop
            jujutsu
            mold
            rustc
            speedtest-cli
            wget
            zsh
          ];

          system.stateVersion = "26.05";
        })
      ];
    };
  };
}
