vim.cmd("set ignorecase")
vim.cmd("set smartcase")
vim.cmd("set autoindent")
vim.cmd("set smartindent")
vim.cmd("set foldmethod=indent")
vim.cmd("set foldlevel=88")
vim.cmd("set textwidth=79")
vim.cmd("set showmatch")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set expandtab")
vim.cmd("set wrap")
vim.g.mapleader = " "
-- Map Ctrl-h to switch to the left window
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", {desc = "dismiss noice messages"})

vim.api.nvim_set_keymap("i", "jk", "<ESC>", { noremap = true })

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
