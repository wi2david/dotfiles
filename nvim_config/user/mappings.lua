-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

local utils = require "astronvim.utils"
local is_available = utils.is_available

local move_cursor_up = {}
local move_cursor_down = {}
local move_cursor_left = {}
local move_cursor_right = {}

if is_available "smart-splits.nvim" then
  move_cursor_up = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  move_cursor_down = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  move_cursor_left = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  move_cursor_right = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
else
  move_cursor_up = { "<C-w>k", desc = "Move to above split" }
  move_cursor_down = { "<C-w>j", desc = "Move to below split" }
  move_cursor_left = { "<C-w>h", desc = "Move to left split" }
  move_cursor_right = { "<C-w>l", desc = "Move to right split" }
end

return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
          require("astronvim.utils.buffer").close(
            bufnr)
        end)
      end,
      desc = "Pick to close",
    },
    -- ["<M-j>"] = { "<Down>", desc = "Down move" },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" }, -- change description but the same command
    -- remapping smart splits
    ["<A-k>"] = move_cursor_up,
    ["<A-j>"] = move_cursor_down,
    ["<A-h>"] = move_cursor_left,
    ["<A-l>"] = move_cursor_right,
  },
  i = {
    -- mapping <C-k>, <C-j>, <C-h>, <C-l> to <Up>, <Down>, <Left>, <Right> of the insert mode
    ["<C-k>"] = { "<Up>", desc = "<Up> in insert mode" },
    ["<C-j>"] = { "<Down>", desc = "<Down> in insert mode" },
    ["<C-h>"] = { "<Left>", desc = "<Left> in insert mode" },
    ["<C-l>"] = { "<Right>", desc = "<Right> in insert mode" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
