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

    # Secrets
    sops-nix.url = "github:Mic92/sops-nix";

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
    vim-polyglot = { url = "github:sheerun/vim-polyglot"; flake = false; };
    editorconfig-nvim = { url = "github:gpanders/editorconfig.nvim"; flake = false; };
    vim-edgemotion = { url = "github:haya14busa/vim-edgemotion"; flake = false; };
    nvim-web-devicons = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };
    popup-nvim = { url = "github:nvim-lua/popup.nvim"; flake = false; };
    plenary-nvim = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    nordic-nvim = { url = "github:andersevenrud/nordic.nvim"; flake = false; };
    nvim-treesitter-context = { url = "github:romgrk/nvim-treesitter-context"; flake = false; };
    telescope-nvim = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    telescope-fzf-native-nvim = { url = "github:nvim-telescope/telescope-fzf-native.nvim"; flake = false; };
    telescope-ghq-nvim = { url = "github:nvim-telescope/telescope-ghq.nvim"; flake = false; };
    telescope-command-palette-nvim = { url = "github:LinArcX/telescope-command-palette.nvim"; flake = false; };
    lualine-nvim = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
    cmp-nvim-lsp = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    cmp-buffer = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    cmp-cmdline = { url = "github:hrsh7th/cmp-cmdline"; flake = false; };
    nvim-cmp = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    lsp-format-nvim = { url = "github:lukas-reineke/lsp-format.nvim"; flake = false; };
    nvim-lspconfig = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    which-key-nvim = { url = "github:folke/which-key.nvim"; flake = false; };
    nvim-notify = { url = "github:rcarriga/nvim-notify"; flake = false; };

    # fish shell plugins
    fish-done = {
      url = "github:franciscolourenco/done";
      flake = false;
    };

    fish-ghq = {
      url = "github:decors/fish-ghq";
      flake = false;
    };

    fish-fzf = {
      url = "github:jethrokuan/fzf";
      flake = false;
    };

    fish-foreign-env = {
      url = "github:oh-my-fish/plugin-foreign-env";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixos-unstable, darwin, home-manager, flake-utils-plus, sops-nix, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (nixos-unstable.lib) nixosSystem;
      inherit (flake-utils-plus.lib) mkFlake eachDefaultSystem eachSystem;
      inherit (nixpkgs) lib;
    in
    {
      nixosConfigurations = {
        define7 = nixosSystem {
          system = "x86_64-linux";
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ (import ./overlays) ];
              home-manager.extraSpecialArgs = inputs;
            })
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            ./modules
            ./system/nixos
            ./hosts/define7
          ];
        };
      };

      darwinConfigurations = {
        LF2107010038 = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ (import ./overlays) ];
              home-manager.extraSpecialArgs = inputs;
            })
            home-manager.darwinModules.home-manager
            ./system/shared.nix
            ./system/darwin
            ./hosts/LF2107010038
          ];
        };
      };
    } // lib.recursiveUpdate
      (eachSystem [ "x86_64-linux" ] (system:
        let
          pkgs = import nixos-unstable {
            inherit system;
          };
        in
        {
          defaultPackage = pkgs.writeText "cachix-agents.json" (builtins.toJSON {
            agents = {
              define7 = self.nixosConfigurations.define7.config.system.build.toplevel;
            };
          });
        }))
      (eachSystem [ "x86_64-darwin" "aarch64-darwin" ] (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            crossSystem = "aarch64-darwin";
          };
        in
        {
          defaultPackage = pkgs.writeText "cachix-agents.json" (builtins.toJSON {
            agents = {
              LF2107010038 = self.darwinConfigurations.LF2107010038.config.system.build.toplevel;
            };
          });
        }))
    // eachDefaultSystem (system:
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
          };
      });
}
