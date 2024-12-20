require("mason").setup()
require("mason-lspconfig").setup()

-- Load and configure LSP servers via lspconfig
local lspconfig = require("lspconfig")
local cmp = require("cmp")


local function on_attach(client, bufnr)
  -- Disable formatting capabilities for clangd
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  -- Disable semantic tokens
  client.server_capabilities.semanticTokensProvider = nil

  -- Disable LSP highlight groups
  vim.api.nvim_clear_autocmds({ group = vim.api.nvim_create_augroup("lsp_document_highlight", {}), buffer = bufnr })

  -- Automatically show diagnostics on hover
  vim.cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float(nil, { focusable = false })]])
end

lspconfig.clangd.setup({
  on_attach = on_attach,
  cmd = { "clangd", "--header-insertion=never", "--header-insertion-decorators=0" },
  settings = {
    clangd = {
      completion = {
        imports = {
          sort = false  -- Disable import sorting
        }
      }
    }
  }
})

-- Ensure servers for autocompletion
local servers = { "clangd", "pyright", "lua_ls", "ts_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
end

-- Setup nvim-cmp
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif require('luasnip').expand_or_jumpable() then
            require('luasnip').expand_or_jump()
        else
            fallback()
        end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif require('luasnip').jumpable(-1) then
            require('luasnip').jump(-1)
        else
            fallback()
        end
        end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  },
  formatting = {
    format = require("lspkind").cmp_format({
      mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
      maxwidth = 50,
    }),
  },
})

-- Optional: Use Trouble for better diagnostics display
require("trouble").setup {}

-- Keymaps for diagnostics
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

