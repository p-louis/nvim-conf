---@diagnostic disable: missing-fields
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = "plugins" },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = function()
      require('ibl').setup()
    end,
  },
  {
    'ThePrimeagen/git-worktree.nvim',
    config = function()
      require("git-worktree").setup()
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        options = {
          number = false,
          relativenumber = false,
        },
        --height = 40,
        width = 180,
      },
      plugins = {
        tmux = { enabled = true },
      },
    },
  },
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      'nvim-neotest/nvim-nio',
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
      "Mgenuit/nvim-dap-kotlin",
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'
      local widgets = require("dap.ui.widgets");
      local sidebar = widgets.sidebar(widgets.scopes);

      require('mason-nvim-dap').setup {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_setup = true,

        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
          'kotlin',
          'go',
        },
      }

      -- Basic debugging keymaps, feel free to change to your liking!
      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>dB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })

      -- Dap UI setup
      -- For more information, see |:help nvim-dap-ui|
      dapui.setup {
        -- Set icons to characters that are more likely to work in every terminal.
        --    Feel free to remove or use ones that you like more! :)
        --    Don't feel like these are good choices.
        icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
        controls = {
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
            disconnect = '',
          },
        },
      }
      vim.keymap.set('n', '<leader>du', sidebar.open, { desc = 'Open debugging sidebar' })
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close

      -- Install golang specific config
      require('dap-go').setup()
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      local rt = require("rust-tools")
      rt.setup({
        executor = require("rust-tools.executors").termopen,
        server = {
          on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions,
              { buffer = bufnr, desc = 'Hover Actions' })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group,
              { buffer = bufnr, desc = 'Code Action Group' })
          end,
          ['rust-analyzer'] = {
            cargo = {
              autoReload = true
            }
          }
        },
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
      })
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "rust", "toml" },
    config = function(_, opts)
      local crates = require("crates")
      crates.setup(opts)
      crates.show()
      vim.keymap.set('n', '<leader>rcu', function() crates.upgrade_all_crates() end,
        { desc = 'Update Crates' })
    end,
  },
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup()
      vim.keymap.set('n', '<leader>mdp', '<cmd>Glow<CR>', { desc = 'Preview Markdown' })
    end,
    ft = "markdown",
    cmd = "Glow",
    lazy = true,
  },

  {
    "zk-org/zk-nvim",
    config = function()
      require("zk").setup({
        -- See Setup section below
      })
    end
  },
  -- { import = 'custom.plugins' },
}, {})

require('settings')
require('mappings')


require("zk").setup({
  -- can be "telescope", "fzf", "fzf_lua", "minipick", or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope", "fzf", "fzf_lua", or "minipick"
  picker = "telescope",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})

vim.keymap.set('n', '<leader>nn', ':ZkNew<CR>', { desc = '[N]ew [N]ote' })
vim.keymap.set('n', '<leader>nfn', ':ZkNotes<CR>', { desc = '[F]ind [N]otes by Title' })
vim.keymap.set('n', '<leader>nft', ':ZkTags<CR>', { desc = '[F]ind [N]otes by Tag' })
vim.keymap.set('n', '<leader>nfl', ':ZkLinks<CR>', { desc = '[F]ind [N]otes by Links' })
vim.keymap.set('n', '<leader>nl', ':ZkInsertLink<CR>', { desc = '[N]ote insert [L]ink' })
vim.keymap.set('v', '<leader>nfc', ':ZkMatch<CR>', { desc = '[F]ind [N]otes by Content' })
vim.keymap.set('v', '<leader>nc', ':ZkNewFromContentSelection<CR>', { desc = '[N]ote from [C]ontent' })
vim.keymap.set('v', '<leader>nt', ':ZkNewFromTitleSelection<CR>', { desc = '[N]ote from [T]itle' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('lsp')

vim.keymap.set('n', '<leader>gr', ':r !tr -dc a-z0-9 < /dev/urandom | head -c 36;echo<CR>',
  { desc = "Generate Random UID" })


require('dap').adapters.kotlin = {
  type = 'executable',
  command = 'kotlin-debug-adapter',
  options = {
    initialize_timeout_sec = 15,
    disconnect_timeout_sec = 15,
    auto_continue_if_many_stopped = false,
  },
}

require('dap').configurations.kotlin = {
  {
    type = 'kotlin',
    request = 'launch',
    name = 'Application',
    mainClass = 'io.ktor.server.jetty.EngineMain',
    projectRoot = '${workspaceFolder}',
  },
}

-- Colorscheme
vim.cmd('colorscheme catppuccin')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
