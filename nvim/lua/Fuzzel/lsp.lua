local lspconfig = require 'lspconfig'
local omnisharp_extended = require 'omnisharp_extended'
local rust_tools = require 'rust-tools'

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  nmap("<C-space>", rust_tools.hover_actions.hover_actions, 'Hover Actions' )
  -- Code action groups
  nmap("<Leader>a", rust_tools.code_action_group.code_action_group, 'Code Action Group')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true})
    end
  end,
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local language_servers = {
  bashls = {},
  cssls = {},
  dhall_lsp_server = {},
  dockerls = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  },
  html = {},
  elixirls = {
    cmd = { "elixir-ls" },
  },
  jsonls = {},
  jsonnet_ls = {},
  jdtls = {},
  kotlin_language_server = {},
  ansiblels = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        runtime = {
          version = 'LuaJIT',
        },
        telemetry = {
          enable = false,
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    }
  },
  nickel_ls = {},
  nil_ls = {
    settings = {
      ['nil'] = {
        formatting = { command = { "alejandra" } },
      },
    }
  },
  ocamllsp = {},
  omnisharp = {
    cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    handlers = {
      ["textDocument/definition"] = omnisharp_extended.handler,
    },
  },
  postgres_lsp = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true
        },
      },
    },
  },
  terraformls = {},
  ts_ls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
}
for server, server_config in pairs(language_servers) do
        local config = { on_attach = on_attach }

        if server_config then
            for k, v in pairs(server_config) do
                config[k] = v
            end
        end

        lspconfig[server].setup(config)
    end

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local cmp_autopairs = require('nvim-autopairs.completion.cmp')

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'

---@diagnostic disable-next-line: missing-fields
cmp.setup {
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

cmp.event:on {
  'confirm_done',
  cmp_autopairs.on_confirm_done()
}

-- Rust Stuff
rust_tools.setup({
  executor = require("rust-tools.executors").termopen,
  server = {
    on_attach = on_attach,
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

-- ZK stuff
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

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
