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
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Undotree --- Essential
    'mbbill/undotree',
    -- Detect tabstop and shiftwidth automatically
    -- 'tpope/vim-sleuth',

    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    {
        -- Autocompletion
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    {
        -- Autoformatting
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            local null_ls = require "null-ls"

            local formatting = null_ls.builtins.formatting
            local lint = null_ls.builtins.diagnostics

            local sources = {
                formatting.prettier,
                formatting.stylua,

                lint.shellcheck,
            }

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            null_ls.setup {
                debug = true,
                sources = sources,
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                                -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            }
        end,
    },

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim',  opts = {} },
    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = 'Preview git hunk' })

                -- don't override the built-in and fugitive keymaps
                local gs = package.loaded.gitsigns
                vim.keymap.set({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
                vim.keymap.set({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
            end,
        },
    },

    -- Colorscheme of choice
    {
        'catppuccin/nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme 'catppuccin-mocha'
        end,
    },


    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'catppuccin',
                component_separators = { left = '', right = '' },
                section_separators = {
                    left = '',
                    right = '',
                }
            },

        },
    },

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
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("refactoring").setup()
        end,
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
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
            -- Creates a beautiful debugger UI
            'rcarriga/nvim-dap-ui',

            -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',

            -- Add your own debuggers here
            'leoluz/nvim-dap-go',
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
                    'delve',
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
                        pause = '⏸',
                        play = '▶',
                        step_into = '⏎',
                        step_over = '⏭',
                        step_out = '⏮',
                        step_back = 'b',
                        run_last = '▶▶',
                        terminate = '⏹',
                        disconnect = '⏏',
                    },
                },
            }
            vim.keymap.set('n', '<leader>ds', sidebar.open, { desc = 'Open debugging sidebar' })
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
        cmd = "Glow"
    },
    {
        "nvim-neorg/neorg",
        cmd = "Neorg",
        ft = "norg",
        run = ":Neorg sync-parsers", -- This is the important bit!
        config = function()
            require('neorg').setup {
                load = {
                    ["core.defaults"] = {},
                    ['core.neorgcmd'] = {},
                    ['core.summary'] = {},
                    ['core.journal'] = {},
                    ['core.autocommands'] = {},
                    ["core.concealer"] = {},
                    ['core.integrations.treesitter'] = { config = {} },
                    ['core.ui'] = {},
                    ['core.presenter'] = {
                        config = {
                            zen_mode = "zen-mode",
                        }
                    },
                    --['core.ui.calendar'] = {}, -- Currently broken, requires nvim 0.10+
                    ['core.completion'] = {
                        config = {
                            engine = "nvim-cmp",
                            name = "[Neorg]",
                        },
                    },
                    ["core.dirman"] = {
                        config = {
                            workspaces = {
                                work = "~/.local/share/notes/work",
                                home = "~/.local/share/notes/home",
                            },
                            default_workspace = "work",
                        }
                    },
                    ["core.keybinds"] = {
                        config = {
                            default_keybinds = true,
                            neorg_leader = "\\",
                            hook = function(keybinds)
                                keybinds.map("norg", "n", "<leader>nps",
                                    "<cmd>Neorg presenter start<CR>")
                            end,
                        },
                    },
                },
            }
        end,
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },

    -- { import = 'custom.plugins' },
}, {})

require('settings')
require('mappings')

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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
