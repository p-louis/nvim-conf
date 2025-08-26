{ inputs }:
let
  inherit (inputs.nixpkgs) legacyPackages;
in
rec {
  mkVimPlugin =
    { system }:
    let
      inherit (pkgs) vimUtils;
      inherit (vimUtils) buildVimPlugin;
      pkgs = legacyPackages.${system};
    in
    buildVimPlugin {
      name = "Fuzzel";
      postInstall = ''
        rm -rf $out/init.lua
      '';
      src = ../nvim;

      nvimRequireCheck = [ "Fuzzel.mappings" ];
    };

  mkNeovimPlugins =
    { system }:
    let
      inherit (pkgs) vimPlugins;
      pkgs = legacyPackages.${system};
      fuzzelNvim = mkVimPlugin { inherit system; };
    in
    [
      # languages
      vimPlugins.nvim-lspconfig
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.rust-tools-nvim
      vimPlugins.rust-vim
      vimPlugins.vim-just
      vimPlugins.indent-blankline-nvim
      vimPlugins.zk-nvim
      vimPlugins.neodev-nvim

      # CMP
      vimPlugins.nvim-cmp
      vimPlugins.cmp-nvim-lsp
      vimPlugins.friendly-snippets

      # telescope
      vimPlugins.plenary-nvim
      vimPlugins.telescope-nvim
      vimPlugins.telescope-fzf-native-nvim
      vimPlugins.git-worktree-nvim

      # Misc
      vimPlugins.vim-fugitive
      vimPlugins.vim-rhubarb
      vimPlugins.nvim-autopairs
      vimPlugins.nvim-surround
      vimPlugins.marks-nvim
      vimPlugins.oil-nvim

      # theme
      vimPlugins.catppuccin-nvim
      vimPlugins.everforest
      vimPlugins.lush-nvim
      vimPlugins.zenbones-nvim

      # floaterm
      vimPlugins.vim-floaterm

      # extras
      vimPlugins.todo-comments-nvim
      vimPlugins.comment-nvim
      vimPlugins.lualine-nvim
      vimPlugins.which-key-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.lualine-nvim
      vimPlugins.noice-nvim
      vimPlugins.undotree
      vimPlugins.nvim-colorizer-lua
      vimPlugins.nvim-notify
      vimPlugins.nvim-treesitter-context
      vimPlugins.nvim-web-devicons
      vimPlugins.omnisharp-extended-lsp-nvim
      vimPlugins.rainbow-delimiters-nvim
      vimPlugins.trouble-nvim
      vimPlugins.render-markdown-nvim

      # configuration
      fuzzelNvim
    ];

  mkExtraPackages =
    { system }:
    let
      inherit (pkgs) nodePackages python3Packages;
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      kotlin-lsp = import ../derivations/kotlin-lsp.nix { inherit pkgs; };
    in
    [
      # language servers
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      pkgs.ansible-language-server
      pkgs.ansible-lint
      pkgs.cuelsp
      pkgs.gopls
      pkgs.jsonnet-language-server
      pkgs.lua-language-server
      pkgs.nil
      pkgs.nls
      pkgs.postgres-lsp
      pkgs.rust-analyzer
      pkgs.pyright
      pkgs.terraform-ls
      pkgs.jdt-language-server
      pkgs.elixir-ls
      pkgs.roc
      kotlin-lsp

      # formatters
      pkgs.alejandra
      pkgs.gofumpt
      pkgs.golines
      python3Packages.black
    ];

  mkExtraConfig = ''
    lua << EOF
      require('Fuzzel')
    EOF
  '';

  mkNeovim =
    { system }:
    let
      inherit (pkgs) lib neovim;
      extraPackages = mkExtraPackages { inherit system; };
      pkgs = legacyPackages.${system};
      start = mkNeovimPlugins { inherit system; };
    in
    neovim.override {
      configure = {
        packages.main = { inherit start; };
        customRC = mkExtraConfig;
      };
      extraMakeWrapperArgs = ''--suffix PATH : "${lib.makeBinPath extraPackages}"'';
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };

  mkHomeManager =
    { system }:
    let
      extraConfig = mkExtraConfig;
      extraPackages = mkExtraPackages { inherit system; };
      plugins = mkNeovimPlugins { inherit system; };
    in
    {
      inherit extraConfig extraPackages plugins;
      defaultEditor = true;
      enable = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
    };
}
