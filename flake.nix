{
  description = "Nix system configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Darwin
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ISO images and VMs
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
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
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
    };

    ## NeoVim Plugins
    vim-polyglot = {
      url = "github:sheerun/vim-polyglot";
      flake = false;
    };
    editorconfig-nvim = {
      url = "github:gpanders/editorconfig.nvim";
      flake = false;
    };
    vim-edgemotion = {
      url = "github:haya14busa/vim-edgemotion";
      flake = false;
    };
    nvim-web-devicons = {
      url = "github:kyazdani42/nvim-web-devicons";
      flake = false;
    };
    popup-nvim = {
      url = "github:nvim-lua/popup.nvim";
      flake = false;
    };
    plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    dressing-nvim = {
      url = "github:stevearc/dressing.nvim";
      flake = false;
    };
    nightfox-nvim = {
      url = "github:EdenEast/nightfox.nvim";
      flake = false;
    };
    nvim-treesitter-context = {
      url = "github:lewis6991/nvim-treesitter-context";
      flake = false;
    };
    telescope-nvim = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    telescope-fzf-native-nvim = {
      url = "github:nvim-telescope/telescope-fzf-native.nvim";
      flake = false;
    };
    telescope-ghq-nvim = {
      url = "github:nvim-telescope/telescope-ghq.nvim";
      flake = false;
    };
    lualine-nvim = {
      url = "github:nvim-lualine/lualine.nvim";
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
    cmp-cmdline = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    cmp-nvim-lsp-document-symbol = {
      url = "github:hrsh7th/cmp-nvim-lsp-document-symbol";
      flake = false;
    };
    cmp-nvim-lsp-signature-help = {
      url = "github:hrsh7th/cmp-nvim-lsp-signature-help";
      flake = false;
    };
    luasnip = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    cmp-luasnip = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    nvim-cmp = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    lsp-format-nvim = {
      url = "github:lukas-reineke/lsp-format.nvim";
      flake = false;
    };
    nvim-lspconfig = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    nvim-notify = {
      url = "github:rcarriga/nvim-notify";
      flake = false;
    };
    lspkind-nvim = {
      url = "github:onsails/lspkind-nvim";
      flake = false;
    };
    gitsigns-nvim = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    lspsaga-nvim = {
      url = "github:tami5/lspsaga.nvim";
      flake = false;
    };
    legendary-nvim = {
      url = "github:mrjones2014/legendary.nvim";
      flake = false;
    };
    impatient-nvim = {
      url = "github:lewis6991/impatient.nvim";
      flake = false;
    };
    nvim-gps = {
      url = "github:SmiteshP/nvim-gps";
      flake = false;
    };
    hop-nvim = {
      url = "github:phaazon/hop.nvim";
      flake = false;
    };
    lightspeed-nvim = {
      url = "github:ggandor/lightspeed.nvim";
      flake = false;
    };
    lualine-lsp-progress = {
      url = "github:arkav/lualine-lsp-progress";
      flake = false;
    };

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

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    flake-utils-plus,
    sops-nix,
    nixos-generators,
    poetry2nix,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (nixpkgs.lib) nixosSystem;
    inherit (flake-utils-plus.lib) eachDefaultSystem;
    inherit (nixpkgs) lib;

    homeManagerConfigModule = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = inputs;
      };
    };
    overlays = {
      nixpkgs.overlays = [(import ./overlays)];
    };
  in
    {
      homeConfigurations = let
        configuration = import ./home-manager;
        system = "x86_64-linux";
        stateVersion = "21.11";
        homeDirectory = "/home/vscode";
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          overlays = [(import ./overlays)];
        };
        extraSpecialArgs = inputs;
      in {
        # For GitHub Codespaces
        vscode = home-manager.lib.homeManagerConfiguration {
          inherit configuration system stateVersion homeDirectory pkgs extraSpecialArgs;
          username = "vscode";
        };

        # For GitHub Actions
        runner = home-manager.lib.homeManagerConfiguration {
          inherit configuration system stateVersion homeDirectory pkgs extraSpecialArgs;
          username = "runner";
        };
        sakuraba = home-manager.lib.homeManagerConfiguration {
          inherit configuration system stateVersion homeDirectory pkgs extraSpecialArgs;
          username = "sakuraba";
        };
      };

      nixosConfigurations = {
        define7 = nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            homeManagerConfigModule
            overlays
            ./modules/nixos
            ./hosts/define7
          ];
        };

        air11 = nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            homeManagerConfigModule
            overlays
            ./modules/nixos
            ./hosts/air11
          ];
        };
      };

      darwinConfigurations = {
        LF2107010038 = darwinSystem {
          system = "aarch64-darwin";
          modules = [
            home-manager.darwinModules.home-manager
            homeManagerConfigModule
            overlays
            ./modules/darwin
            ./hosts/LF2107010038
          ];
        };
      };

      packages."x86_64-linux".default = let
        pkgs = import nixpkgs {system = "x86_64-linux";};
      in
        pkgs.writeText "cachix-agents.json" (builtins.toJSON {
          agents = {
            define7 = self.nixosConfigurations.define7.config.system.build.toplevel;
          };
        });
      packages."x86_64-linux".iso = let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [(import ./overlays)];
        };
      in
        nixos-generators.nixosGenerate {
          inherit pkgs;
          modules = [
            home-manager.darwinModules.home-manager
            homeManagerConfigModule
            overlays
            ./hosts/iso
          ];
          format = "install-iso";
        };

      packages."aarch64-darwin".default = let
        pkgs = import nixpkgs {system = "aarch64-darwin";};
      in
        pkgs.writeText "cachix-agents.json" (builtins.toJSON {
          agents = {
            LF2107010038 = self.darwinConfigurations.LF2107010038.config.system.build.toplevel;
          };
        });
    }
    // eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          poetry2nix.overlay
          (_final: prev: {
            machinectl = prev.poetry2nix.mkPoetryApplication {
              projectDir = ./bin/machinectl;
            };
          })
        ];
      };
    in {
      packages = {
        inherit (pkgs) machinectl;
      };
      defaultApp = pkgs.machinectl;
    });
}
