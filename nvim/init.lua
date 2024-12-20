require("mappings")
require("plugins")

if vim.g.vscode then
    -- VSCode extension
else
    vim.opt.tabstop = 4       -- Number of visual spaces per TAB
    vim.opt.shiftwidth = 4     -- Number of spaces for each indentation step
    vim.opt.expandtab = true   -- Use spaces instead of tabs
    vim.opt.smarttab = true    -- Tab inserts spaces according to 'shiftwidth'
    vim.opt.autoindent = true  -- Maintain indentation on a new line
    vim.opt.number = true
    -- vim.opt.relativenumber = true
    vim.o.background = ""
    vim.opt.termguicolors = true
    vim.cmd("colorscheme kanagawa-dragon");
end
