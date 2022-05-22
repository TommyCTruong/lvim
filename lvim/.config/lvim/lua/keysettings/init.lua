lvim.leader = "space"

local opts = {
  relativenumber = true, -- Set relative numbered lines
  scrolloff = 8, -- Determines the number of context lines you would like to see above and below the cursor ignorecase = true, -- Ignore case in search
  smartcase = true, -- Case-sensitive search when search term contains uppercase characters. Otherwise, case-sensitive search
  timeoutlen = 200, -- Time to wait for a mapped sequence to complete (in milliseconds)
  termguicolors = true,
  wrap = false,
}
for k, v in pairs(opts) do
  vim.opt[k] = v
end

-- Disable lvim default key mappings.
lvim.keys.insert_mode["jk"] = nil
lvim.keys.insert_mode["kj"] = nil
lvim.keys.insert_mode["jj"] = nil
-- Disable key mapping to Ex mode.
lvim.keys.normal_mode["Q"] = "<NOP>"
-- Disable arrow keys in insert mode.
lvim.keys.insert_mode["<Up>"] = "<NOP>"
lvim.keys.insert_mode["<Down>"] = "<NOP>"
lvim.keys.insert_mode["<Left>"] = "<NOP>"
lvim.keys.insert_mode["<Right>"] = "<NOP>"
-- Resize with keys in normal mode.
lvim.keys.normal_mode["<Up>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<Down>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<Left>"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["<Right>"] = ":vertical resize +2<CR>"
-- Undo break points.
lvim.keys.insert_mode[","] = ",<c-g>u"
lvim.keys.insert_mode["."] = ".<c-g>u"
lvim.keys.insert_mode["!"] = "!<c-g>u"
lvim.keys.insert_mode["?"] = "?<c-g>u"
lvim.keys.insert_mode[" "] = " <c-g>u"
-- Alternative way to save.
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
-- Use CTRL+C as an alternative to <ESC>...
lvim.keys.normal_mode["<C-c>"] = "<ESC>"
-- Backtick is so annoying to press on a Swedish keyboard...
lvim.keys.normal_mode["+"] = "`"
-- Don't yank new-line character.
lvim.keys.normal_mode["Y"] = "y$"
-- Only paste most recent yank.
lvim.keys.normal_mode["p"] = '"0p'
lvim.keys.normal_mode["P"] = '"0P'
lvim.keys.visual_mode["p"] = '"0p'
lvim.keys.visual_mode["P"] = '"0P'
--- Cut overrides yank register.
lvim.keys.normal_mode["x"] = '"0x'
-- Cut overrides yank register.
lvim.keys.visual_mode["x"] = '"0x'
