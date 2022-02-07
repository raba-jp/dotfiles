{
  description = "Nix system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # NixOS nixos-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Darwin
    darwin-stable.url = "github:nixos/nixpkgs/nixpkgs-21.11-darwin";
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager.url = "github:nix-community/home-manager";

    # ISO images and VMs
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixos-unstable";
    };

    # Shell
    devshell.url = "github:numtide/devshell";

    # Utility
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils-plus = {
      url = "github:gytis-ivaskevicius/flake-utils-plus";
      inputs.flake-utils.follows = "flake-utils";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    ## NeoVim Plugins
    vim-edgemotion = {
      url = "github:haya14busa/vim-edgemotion";
      flake = false;
    };
    format-nvim = {
      url = "github:lukas-reineke/format.nvim";
      flake = false;
    };
    nordic-nvim = {
      url = "github:andersevenrud/nordic.nvim";
      flake = false;
    };
    cmp-nvim-lsp = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    cmp-buffer = {
      url = "github:hrsh7th/cmp-buffer";
      flake = false;
    };
    lspsaga-nvim = {
      url = "github:tami5/lspsaga.nvim";
      flake = false;
    };
    telescope-ghq-nvim = {
      url = "github:nvim-telescope/telescope-ghq.nvim";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    which-key-nvim = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };

    telescope-command-palette-nvim = {
      url = "github:LinArcX/telescope-command-palette.nvim";
      flake = false;
    };

    cheatsheet-nvim = {
      url = "github:sudormrfbin/cheatsheet.nvim";
      flake = false;
    };

    octo-nvim = {
      url = "github:pwntester/octo.nvim";
      flake = false;
    };
  };

  outputs = { self, nixos-unstable, darwin, home-manager, flake-utils-plus, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixos-unstable.lib) nixosSystem;
      inherit (flake-utils-plus.lib) mkFlake eachDefaultSystem eachSystem;
    in
    {
      nixosConfigurations = {
        define7 = nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ ((import ./overlays) inputs) ];
            })
            home-manager.nixosModules.home-manager
            ./modules
            ./system/nixos
            ./hosts/define7
          ];
        };

        xps13 = nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ ((import ./overlays) inputs) ];
            })
            home-manager.nixosModules.home-manager
            ./modules
            ./system/nixos
            ./hosts/xps13
          ];
        };
      };

      darwinConfigurations = {
        LF2107010038 = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ ((import ./overlays) inputs) ];
            })
            home-manager.darwinModules.home-manager
            ./system/shared.nix
            ./system/darwin
            ./hosts/LF2107010038
          ];
        };
      };

      defaultPackage = {
        x86_64-linux = (import nixos-unstable { system = "x86_64-linux"; }).writeText "cachix-agents.json" (builtins.toJSON {
          agents = {
            define7 = self.nixosConfigurations.define7.config.system.build.toplevel;
            xps13 = self.nixosConfigurations.xps13.config.system.build.toplevel;
          };
        });
        aarch64-darwin = (import nixos-unstable { system = "aarch64-darwin"; }).writeText "cachix-agents.json" (builtins.toJSON {
          agents = {
            LF2107010038 = self.darwinConfigurations.LF2107010038.config.system.build.toplevel;
          };
        });
      };
    } // eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.devshell.overlay
          ];
        };
      in
      {

        devShell = pkgs.devshell.mkShell
          {
            imports = [ "${pkgs.devshell.extraModulesDir}/git/hooks.nix" ];

            packages = [ pkgs.treefmt pkgs.nixpkgs-fmt pkgs.stylua pkgs.shfmt ];

            commands = [
              {
                name = "switch-define7";
                command = "sudo nixos-rebuild switch --flake .#define7";
                category = "switch";
              }
              {
                name = "switch-xps13";
                command = "sudo nixos-rebuild switch --flake .#xps13";
                category = "switch";
              }
              {
                name = "switch-LF2107010038";
                command = ''
                  nix build './#darwinConfigurations.LF2107010038.system'
                  ./result/sw/bin/darwin-rebuild switch --flake ./
                '';
                category = "switch";
              }
              {
                name = "info";
                help = "Print nix informations";
                command = ''
                  nix-shell -p nix-info --run "nix-info -m"
                '';
              }
            ];

            git.hooks = {
              enable = true;
              pre-commit.text = ''
                #!/bin/sh
                treefmt
  
                for FILE in `git diff --staged --name-only`; do
                    git add $FILE
                done
              '';
            };
          };
      });
}
