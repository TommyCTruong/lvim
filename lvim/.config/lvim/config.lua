local util = require "util"

-- *
-- Settings
-- *
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

-- HACK:: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

lvim.debug = false
lvim.format_on_save = true
lvim.lint_on_save = true

lvim.leader = "space"

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

-- *
-- Terminal
-- *
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shading_factor = 1
lvim.builtin.terminal.execs = {}

-- *
-- Dashboard
-- *
lvim.builtin.dashboard.active = true
lvim.builtin.dashboard.custom_section.a.command = "Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings"
lvim.builtin.dashboard.custom_header = {
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  " ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
  " ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
  " ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
  " ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
  " ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
  " ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
}

-- *
-- Nvimtree
-- *
lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.width = 50
lvim.builtin.nvimtree.quit_on_open = 0
lvim.builtin.nvimtree.ignore = { ".git", "node_modules", ".cache", "vendor" }

-- Autocommands
-- *
lvim.autocommands.custom_groups = {
  -- On entering a go file, set the tab spacing and shift width to 4
  { "BufWinEnter", "*.go", "setlocal ts=4 sw=4" },
}
-- Go to last loc when opening a buffer
vim.cmd [[
   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
]]

-- *
-- LSP
-- *
lvim.lsp.diagnostics.virtual_text = false

-- *
-- Terminal
-- *
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shading_factor = 1
lvim.builtin.terminal.execs = {}

-- *
-- Treesitter
-- *
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.context_commentstring.enable = true
lvim.builtin.treesitter.playground.enable = true
lvim.builtin.treesitter.rainbow.enable = true

-- *
-- Dap (debugger)
-- *
lvim.builtin.dap.active = true

-- Telescope
-- *
lvim.builtin.telescope.active = true
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git", ".cache", "node_modules", "vendor" }
lvim.builtin.telescope.defaults.mappings = (function()
  local actions = require "telescope.actions"
  local trouble = require "trouble.providers.telescope"
  return {
    i = {
      ["<C-n>"] = actions.cycle_history_next,
      ["<C-p>"] = actions.cycle_history_prev,
      ["<C-c>"] = actions.close,
      ["<C-j>"] = actions.move_selection_next,
      ["<C-k>"] = actions.move_selection_previous,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<CR>"] = actions.select_default + actions.center,
      ["<c-x>"] = false,
      ["<c-t>"] = trouble.open_with_trouble,
    },
    n = {
      ["<C-j>"] = actions.move_selection_next,
      ["<-k>"] = actions.move_selection_previous,
      ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["<c-t>"] = trouble.open_with_trouble,
    },
  }
end)()

-- *
-- Whichkey
-- *
lvim.builtin.which_key.active = true
lvim.builtin.which_key.mappings["f"] = nil
lvim.builtin.which_key.mappings["w"] = nil
lvim.builtin.which_key.mappings["b"] = {
  name = "Buffers",
  b = { ":b#<cr>", "Jump to previous buffer" },
  j = { "<cmd>BufferPick<CR>", "Jump to buffer" },
  f = { "<cmd>Telescope buffers<CR>", "Find buffer" },
  w = { "<cmd>BufferWipeout<CR>", "Wipeout buffer" },
  e = {
    "<cmd>BufferCloseAllButCurrent<CR>",
    "Close all but current buffer",
  },
  h = { "<cmd>BufferCloseBuffersLeft<CR>", "Close all buffers to the left" },
  l = {
    "<cmd>BufferCloseBuffersRight<CR>",
    "Close all BufferLines to the right",
  },
  D = {
    "<cmd>BufferOrderByDirectory<CR>",
    "Sort BufferLines automatically by directory",
  },
  L = {
    "<cmd>BufferOrderByLanguage<CR>",
    "Sort BufferLines automatically by language",
  },
}
lvim.builtin.which_key.mappings["h"] = {
  name = "Help",
  t = { "<cmd>:Telescope builtin<CR>", "Telescope" },
  c = { "<cmd>:Telescope commands<CR>", "Commands" },
  h = { "<cmd>:Telescope help_tags<CR>", "Help Pages" },
  m = { "<cmd>:Telescope man_pages<CR>", "Man Pages" },
  k = { "<cmd>:Telescope keymaps<CR>", "Key Maps" },
  s = { "<cmd>:Telescope highlights<CR>", "Search Highlight Groups" },
  l = { [[<cmd>TSHighlightCapturesUnderCursor<CR>]], "Highlight Groups at cursor" },
  f = { "<cmd>:Telescope filetypes<CR>", "File Types" },
  o = { "<cmd>:Telescope vim_options<CR>", "Options" },
  a = { "<cmd>:Telescope autocommands<CR>", "Auto Commands" },
  p = {
    name = "Packer",
    p = { "<cmd>PackerSync<CR>", "Sync" },
    s = { "<cmd>PackerStatus<CR>", "Status" },
    i = { "<cmd>PackerInstall<CR>", "Install" },
    c = { "<cmd>PackerCompile<CR>", "Compile" },
    r = { "<cmd>lua require('utils').reload_lv_config()<CR>", "Reload" },
  },
}
lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  d = { "<cmd>DiffviewOpen<CR>", "DiffView" },
  b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
  s = { "<Cmd>Telescope git_status<CR>", "status" },
}
lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
  d = {
    "<cmd>TroubleToggle lsp_document_diagnostics<CR>",
    "Document Diagnostics",
  },
  w = {
    "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>",
    "Workspace Diagnostics",
  },
  f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
  i = { "<cmd>LspInfo<CR>", "Info" },
  I = { "<cmd>lua require('lsp.handler').implementation()<CR>", "Implementation" },
  j = {
    "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<CR>",
    "Next Diagnostic",
  },
  k = {
    "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<CR>",
    "Prev Diagnostic",
  },
  p = {
    name = "Peek",
    d = { "<cmd>lua require('lsp.peek').Peek('definition')<CR>", "Definition" },
    t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<CR>", "Type Definition" },
    i = { "<cmd>lua require('lsp.peek').Peek('implementation')<CR>", "Implementation" },
  },
  R = { "<cmd>TroubleToggle lsp_references<CR>", "References" },
  q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
  r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
    "Workspace Symbols",
  },
  t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
  T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
}
lvim.builtin.which_key.mappings["s"] = {
  name = "Search",
  f = {
    "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings<CR>",
    "Files",
  },
  b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Search Current Buffer" },
  t = {
    "<cmd>Telescope live_grep vimgrep_arguments=rg,--color=never,--no-heading,--hidden,--with-filename,--line-number,--column,--smart-case,--fixed-strings,--multiline<CR>",
    "Text",
  },
  m = { "<cmd>Telescope marks<CR>", "Marks" },
  g = { "<cmd>Telescope git_files<CR>", "Git files" },
  h = { "<cmd>Telescope help_tags<CR>", "Help" },
  M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
  r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
  R = { "<cmd>Telescope registers<CR>", "Registers" },
  k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
  C = { "<cmd>Telescope commands<CR>", "Commands" },
  c = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
  p = {
    "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
    "Colorscheme with Preview",
  },
}
lvim.builtin.which_key.mappings["t"] = {
  name = "Toggle",
  z = { "<cmd>ZenMode<CR>", "Zen Mode" },
  b = { "<cmd>GitBlameToggle<CR>", "Git blame" },
  t = { "<cmd>Twilight<CR>", "Twilight" },
  i = { "<cmd>IndentBlanklineToggle<CR>", "Indent line" },
  l = { "<cmd>Trouble loclist<CR>", "Trouble Location List" },
  q = { "<cmd>Trouble quickfix<CR>", "Trouble Quickfix List" },
  g = { "<cmd>Glow<cr>", "Markdown Glow" },
  h = {
    function()
      util.toggle "hlsearch"
    end,
    "Highlight",
  },
  n = {
    function()
      util.toggle("relativenumber", true)
      util.toggle "number"
    end,
    "Line Numbers",
  },
  s = {
    function()
      util.toggle "spell"
    end,
    "Spelling",
  },
  w = {
    function()
      util.toggle "wrap"
    end,
    "Word Wrap",
  },
  c = {
    function()
      local updated = util.update("scrolloff", 999)
      if not updated then
        util.update("scrolloff", 8)
      end
    end,
    "Centered",
  },
}
lvim.builtin.which_key.mappings["q"] = {
  name = "Quit",
  q = { "<cmd>:qa<CR>", "Quit" },
  ["!"] = { "<cmd>:qa!<CR>", "Quit without saving" },
}
lvim.builtin.which_key.mappings["p"] = {
  name = "Project",
  w = { ":Telescope file_browser cwd=~/work<CR>", "Browse ~/work" },
}

lvim.plugins = {
  { "lunarvim/colorschemes" },
  {
    "folke/tokyonight.nvim",
    config = function()
      require("user.tokyonight").config()
    end,
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      require("user.gitblame").config()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
      require("user.scroll").config()
    end,
  },
  {
    "edluffy/specs.nvim",
    after = "neoscroll.nvim",
    config = function()
      require("user.specs").config()
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    event = "BufRead",
    config = function()
      require("user.zen").config()
    end,
  },
  {
    "folke/twilight.nvim",
    event = "BufRead",
    config = function()
      require("user.twilight").config()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      require("user.blankline").config()
    end,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      require("user.matchup").config()
    end,
  },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufRead" },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("user.trouble").config()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    requires = "nvim-lua/plenary.nvim",
    event = "BufReadPost",
    config = function()
      require("user.todo").config()
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "unblevable/quick-scope",
    config = function()
      require("user.quickscope").config()
    end,
  },
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
      require("user.numb").config()
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "BufRead",
    config = function()
      require("user.dial").config()
    end,
  },
  { "npxbr/glow.nvim", cmd = "Glow" },
  {
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = function()
      require "user.lightspeed"
    end,
  },
  { "p00f/nvim-ts-rainbow", event = "BufRead" },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
}
