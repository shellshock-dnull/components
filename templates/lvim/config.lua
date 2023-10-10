-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = { "fugitive" }
  },
  {
    "tpope/vim-surround",

    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
  -- {
  --   'f-person/auto-dark-mode.nvim',
  --   config = function ()
  --     require('auto-dark-mode').setup {
  --       update_interval = 1000,
  --       set_dark_mode = function()
  --         lvim.api.nvim_set_option('background', 'dark')
  --         lvim.cmd('colorscheme gruvbox')
  --       end,
  --       set_light_mode = function()
  --         lvim.api.nvim_set_option('background', 'light')
  --         lvim.cmd('colorscheme gruvbox')
  --       end,
  --     }
  --     require('auto-dark-mode').init{}
  --   end
  -- }
  { "f-person/auto-dark-mode.nvim" },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end
  },
  { 'projekt0n/caret.nvim' },
  { 'christoomey/vim-tmux-navigator' },
  { 'dracula/vim' }
}
lvim.colorscheme = "dracula"

-- Change theme based on Mac settings
-- local auto_dark_mode = require('auto-dark-mode')
-- auto_dark_mode.setup({
--   update_interval = 1000,
--   set_dark_mode = function()
--     vim.api.nvim_set_option('background', 'dark')
--     vim.cmd('colorscheme caret')
--   end,
--   set_light_mode = function()
--     vim.api.nvim_set_option('background', 'light')
--     vim.cmd('colorscheme caret')
--   end,
-- })
-- auto_dark_mode.init()

vim.opt.cmdheight = 1             -- more space in the neovim command line for displaying messages
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.shiftwidth = 2            -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.relativenumber = true     -- relative line numbers
vim.opt.wrap = true               -- wrap lines

-- use treesitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
