require("which-key").setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true -- show help message on the command line when the popup is visible
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false -- use `nowait` when creating keymaps
}

local mappings = {
    ["/"] = "Close Buffer",
    ["e"] = "Explorer",
    ["h"] = "No Highlight",
    d = {
        name = "+Debug",
        b = {"<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint"},
        c = {"<cmd>lua require'dap'.continue()<cr>", "Continue"},
        i = {"<cmd>lua require'dap'.step_into()<cr>", "Step Into"},
        o = {"<cmd>lua require'dap'.step_over()<cr>", "Step Over"},
        r = {"<cmd>lua require'dap'.repl.open()<cr>", "Toggle Repl"},
        s = {"<cmd>lua require'dap'.status()<cr>", "Status"}
    },
    t = {
        name = "+Testing",
        n = {"<cmd>TestNearest<cr>", "Test Nearest"},
        f = {"<cmd>TestFile<cr>", "Test File"},
        s = {"<cmd>TestSuite<cr>", "Test Suite"},
        l = {"<cmd>TestLast<cr>", "Test Last"},
        v = {"<cmd>TestVisit<cr>", "Test Visit"},
    },
    g = {
        name = "+Git",
        j = { '<cmd>lua require\"gitsigns\".next_hunk()<CR>'},
        k = { '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'},
        p = {'<cmd>lua require"gitsigns".preview_hunk()<CR>'},
        s = {'<cmd>lua require"gitsigns".stage_hunk()<CR>'},
        u = {'<cmd>lua require"gitsigns".undo_stage_hunk()<CR>'},
        r = {'<cmd>lua require"gitsigns".reset_hunk()<CR>'},
        R = {'<cmd>lua require"gitsigns".reset_buffer()<CR>'},
        b = {'<cmd>lua require"gitsigns".blame_line(true)<CR>'},
        S = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    },
    l = {
        name = "+LSP",
        a = {"<cmd>Lspsaga code_action<cr>", "Code Action"},
        A = {"<cmd>Lspsaga range_code_action<cr>", "Selected Action"},
        d = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        D = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics"},
        f = {"<cmd>LspFormatting<cr>", "Format"},
        i = {"<cmd>LspInfo<cr>", "Info"},
        l = {"<cmd>Lspsaga lsp_finder<cr>", "LSP Finder"},
        L = {"<cmd>Lspsaga show_line_diagnostics<cr>", "Line Diagnostics"},
        p = {"<cmd>Lspsaga preview_definition<cr>", "Preview Definition"},
        K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show hover" },
        g = {
            name = "+GOTO",
            d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
            D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Goto declaration" },
            r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Goto references" },
            i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto implementation" },
            s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "show signature help" },
            p = { "<cmd>lua require'lsp.peek'.Peek('definition')<CR>", "Peek definition" },
        },
        q = {"<cmd>Telescope quickfix<cr>", "Quickfix"},
        r = {"<cmd>Lspsaga rename<cr>", "Rename"},
        t = {"<cmd>LspTypeDefinition<cr>", "Type Definition"},
        x = {"<cmd>cclose<cr>", "Close Quickfix"},
        s = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols"},
        S = {"<cmd>Telescope lsp_workspace_symbols<cr>", "Workspace Symbols"}
    },
    r = {
        name = "+Search",
    },
    S = {name = "+Session", s = {"<cmd>SessionSave<cr>", "Save Session"}, l = {"<cmd>SessionLoad<cr>", "Load Session"}}
}

local wk = require("which-key")
wk.register(mappings, opts)
