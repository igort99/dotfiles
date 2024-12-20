-- Ensure Packer is installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
      fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
      print("Installing packer...")
      vim.cmd([[packadd packer.nvim]])
      return true
    end

    return false
  end

local packer_bootstrap = ensure_packer()

-- Run PackerSync only when plugins.lua is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup({
    function (use)

        -- Packer can manage itself
        use 'wbthomason/packer.nvim'

        -- LSP Support
        use 'neovim/nvim-lspconfig'           -- Configurations for Nvim LSP
        use 'williamboman/mason.nvim'         -- LSP installer
        use 'williamboman/mason-lspconfig.nvim'
        use 'jayp0521/mason-null-ls.nvim'
        use 'jose-elias-alvarez/null-ls.nvim'
        use 'nvim-lua/plenary.nvim'

        -- Autocompletion
        use 'hrsh7th/nvim-cmp'                -- Autocompletion plugin
        use 'hrsh7th/cmp-nvim-lsp'            -- LSP source for nvim-cmp
        use 'hrsh7th/cmp-buffer'              -- Buffer completions
        use 'hrsh7th/cmp-path'                -- Path completions
        use 'hrsh7th/cmp-cmdline'             -- Command line completions
        use 'L3MON4D3/LuaSnip'                -- Snippet engine
        use 'saadparwaiz1/cmp_luasnip'        -- Snippet completions

        use "windwp/nvim-autopairs"

        -- Optional: Fancy icons in autocompletion
        use 'onsails/lspkind-nvim'

        -- For better LSP progress
        use 'j-hui/fidget.nvim'

        -- For displaying diagnostics (like errors, warnings, etc.)
        use 'folke/trouble.nvim'

        use 'rebelot/kanagawa.nvim'

                -- Treesitter for better syntax highlighting and code features
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate' -- Automatically update parsers
        }

        use {
            'nvim-telescope/telescope.nvim', tag = '0.1.8', -- or                            , branch = '0.1.x',
            requires = { {'nvim-lua/plenary.nvim'} }
        }

        if packer_bootstrap then
            require("packer").sync()
        end
    end,
    config = {
        display = {
            open_fn = require("packer").float,
        }
    }
})
