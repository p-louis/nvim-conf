{inputs}: let
  inherit (inputs.nixpkgs) legacyPackages;
in rec {
  mkVimPlugin = {system}: let
    inherit (pkgs) vimUtils;
    inherit (vimUtils) buildVimPlugin;
    pkgs = legacyPackages.${system};
  in
    buildVimPlugin {
      name = "Fuzzel";
      postInstall = ''
        rm -rf $out/.envrc
        rm -rf $out/.gitignore
        rm -rf $out/LICENSE
        rm -rf $out/README.md
        rm -rf $out/flake.lock
        rm -rf $out/flake.nix
        rm -rf $out/justfile
        rm -rf $out/lib
      '';
      src = ../.;
    };

  mkNeovimPlugins = {system}: let
    inherit (pkgs) vimPlugins;
    pkgs = legacyPackages.${system};
    Fuzzel-nvim = mkVimPlugin {inherit system;};
  in [
    # languages
    vimPlugins.nvim-lspconfig
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.rust-tools-nvim
    vimPlugins.rust-vim
    vimPlugins.vim-just
    vimPlugins.indent-blankline-nvim
    vimPlugins.zk-nvim
    vimPlugins.neodev-nvim
    vimPlugins.cmp-nvim-lsp
    vimPlugins.cmp-nvim-lua
    vimPlugins.mason-nvim
    vimPlugins.mason-lspconfig-nvim
    vimPlugins.mason-tool-installer-nvim

    # telescope
    vimPlugins.plenary-nvim
    vimPlugins.telescope-nvim
    vimPlugins.git-worktree-nvim

    # theme
    vimPlugins.tokyonight-nvim

    # floaterm
    vimPlugins.vim-floaterm

    # extras
    vimPlugins.comment-nvim
    vimPlugins.catppuccin-nvim
    vimPlugins.gitsigns-nvim
    vimPlugins.lualine-nvim
    vimPlugins.noice-nvim
    vimPlugins.nui-nvim
    vimPlugins.nvim-colorizer-lua
    vimPlugins.nvim-notify
    vimPlugins.nvim-treesitter-context
    vimPlugins.nvim-web-devicons
    vimPlugins.omnisharp-extended-lsp-nvim
    vimPlugins.rainbow-delimiters-nvim
    vimPlugins.trouble-nvim

    # configuration
    Fuzzel-nvim
  ];

  mkExtraPackages = {system}: let
    inherit (pkgs) nodePackages python3Packages;
    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in [
    # language servers
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    pkgs.cuelsp
    pkgs.gopls
    pkgs.jsonnet-language-server
    pkgs.lua-language-server
    pkgs.nil
    pkgs.nls
    pkgs.postgres-lsp
    pkgs.pyright
    pkgs.terraform-ls

    # formatters
    pkgs.alejandra
    pkgs.gofumpt
    pkgs.golines
    pkgs.terraform
    python3Packages.black
  ];

  mkExtraConfig = ''
    lua << EOF
      require('Fuzzel')
    EOF
  '';

  mkNeovim = {system}: let
    inherit (pkgs) lib neovim;
    extraPackages = mkExtraPackages {inherit system;};
    pkgs = legacyPackages.${system};
    start = mkNeovimPlugins {inherit system;};
  in
    neovim.override {
      configure = {
        customRC = mkExtraConfig;
        packages.main = {inherit start;};
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

  mkHomeManager = {system}: let
    extraConfig = mkExtraConfig;
    extraPackages = mkExtraPackages {inherit system;};
    plugins = mkNeovimPlugins {inherit system;};
  in {
    inherit extraConfig extraPackages plugins;
    defaultEditor = true;
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
  };
}
