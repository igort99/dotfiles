-- Setup mason-null-ls and null-ls for formatting C files on save with clang-format
require("mason-null-ls").setup({
    ensure_installed = { "clang-format" },
    automatic_installation = true,
  })
  
  local null_ls = require("null-ls")
  
  null_ls.setup({
    sources = {
      null_ls.builtins.formatting.clang_format,
    },
    on_attach = function(client, bufnr)
      -- Format on save
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end,
  })