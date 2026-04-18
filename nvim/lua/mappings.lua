require "nvchad.mappings"

local map = vim.keymap.set

-- Enter command mode with ;
map("n", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Mappings cheatsheet" })
