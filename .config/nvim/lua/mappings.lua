require "nvchad.mappings"
local builtin = require('telescope.builtin')
local nvim_tmux_nav = require('nvim-tmux-navigation')

local map = vim.keymap.set

map('n', '<leader>ff', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
map('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
map('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
map('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
map('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
map('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
