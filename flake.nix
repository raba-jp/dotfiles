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
    devshell = {
      url = "github:numtide/devshell";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
      inputs.nixpkgs.follows = "nixpkgs";
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
      url = "github:nvim-treesitter/nvim-treesitter-context";
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
    vim-vsnip = {
      url = "github:hrsh7th/vim-vsnip";
      flake = false;
    };
    cmp-vsnip = {
      url = "github:hrsh7th/cmp-vsnip";
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
    null-ls-nvim = {
      url = "github:jose-elias-alvarez/null-ls.nvim";
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
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    sops-nix,
    nixos-generators,
    poetry2nix,
    ...
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (nixpkgs.lib) nixosSystem;
    inherit (inputs.flake-utils-plus.lib) system;

    homeManagerConfigModule = {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = inputs;
      };
    };
  in {
    homeConfigurations = let
      modules = [./home-manager/minimal.nix];
      pkgs = import nixpkgs {
        system = system.x86_64-linux;
        inherit (self) overlays;
      };
    in {
      # For GitHub Codespaces
      vscode = home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
      };

      # For GitHub Actions
      runner = home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
      };

      sakuraba = home-manager.lib.homeManagerConfiguration {
        inherit modules pkgs;
      };
    };
    nixosConfigurations = {
      define7 = nixosSystem {
        system = system.x86_64-linux;
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          homeManagerConfigModule
          {nixpkgs.overlays = [(import ./overlays)];}
          ./modules/nixos
          ./hosts/define7
        ];
      };

      air11 = nixosSystem {
        system = system.x86_64-linux;
        modules = [
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops
          homeManagerConfigModule
          {nixpkgs.overlays = [(import ./overlays)];}
          ./modules/nixos
          ./hosts/air11
        ];
      };
    };

    darwinConfigurations = {
      LF2107010038 = darwinSystem {
        system = system.aarch64-darwin;
        modules = [
          home-manager.darwinModules.home-manager
          homeManagerConfigModule
          {nixpkgs.overlays = [(import ./overlays)];}
          ./modules/darwin
          ./hosts/LF2107010038
        ];
      };
    };

    overlays = [
      poetry2nix.overlay
      (import ./overlays)
      (_final: prev: {
        machinectl = prev.poetry2nix.mkPoetryApplication {
          projectDir = ./bin/machinectl;
        };
      })
    ];

    packages = {
      "x86_64-linux" = let
        pkgs = import nixpkgs {
          inherit (self) overlays;

          system = system.x86_64-linux;
        };
      in {
        inherit (pkgs) machinectl;

        iso = nixos-generators.nixosGenerate {
          inherit pkgs;
          modules = [
            home-manager.nixosModules.home-manager
            homeManagerConfigModule
            {nixpkgs.overlays = [(import ./overlays)];}
            ./hosts/iso
          ];
          format = "install-iso";
        };

        default = pkgs.writeText "cachix-agents.json" (builtins.toJSON {
          agents = {
            define7 = self.nixosConfigurations.define7.config.system.build.toplevel;
            # air11 = self.nixosConfigurations.air11.config.system.build.toplevel;
          };
        });
      };

      "aarch64-darwin" = let
        pkgs = import nixpkgs {
          system = system.aarch64-darwin;
          inherit (self) overlays;
        };
      in {
        inherit (pkgs) machinectl;

        default = pkgs.writeText "cachix-agents.json" (builtins.toJSON {
          agents = {
            LF2107010038 = self.darwinConfigurations.LF2107010038.config.system.build.toplevel;
          };
        });
      };
    };

    defaultPackage = {
      "${system.x86_64-linux}" = self.packages."${system.x86_64-linux}".default;
      "${system.aarch64-darwin}" = self.packages."${system.aarch64-darwin}".default;
    };
  };
}
