local util = require("util")

lvim.debug = false
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.lsp.automatic_servers_installation = true

-- *
-- Settings
-- *
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

-- *
-- Whichkey
-- *
-- Reset defaults
lvim.builtin.which_key.mappings["g"] = nil
lvim.builtin.which_key.mappings[";"] = nil
lvim.builtin.which_key.mappings["f"] = nil
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["w"] = nil
lvim.builtin.which_key.mappings["b"] = nil
lvim.builtin.which_key.mappings["l"] = nil
lvim.builtin.which_key.mappings["s"] = nil
lvim.builtin.which_key.mappings["T"] = nil
-- Custom key bindings
lvim.builtin.which_key.mappings["t"] = {
	name = "Toggle",
	z = { "<cmd>ZenMode<CR>", "Zen Mode" },
	b = { "<cmd>GitBlameToggle<CR>", "Blame" },
	i = { "<cmd>IndentBlanklineToggle<CR>", "Indent line" },
	l = { "<cmd>Trouble loclist<CR>", "Location List" },
	q = { "<cmd>Trouble quickfix<CR>", "Quickfix List" },
	g = { "<cmd>Glow<cr>", "Markdown" },
	h = {
		function()
			util.toggle("hlsearch")
		end,
		"Highlight",
	},
	n = {
		function()
			util.toggle("relativenumber", true)
			util.toggle("number")
		end,
		"Line Numbers",
	},
	s = {
		function()
			util.toggle("spell")
		end,
		"Spelling",
	},
	w = {
		function()
			util.toggle("wrap")
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
lvim.builtin.which_key.mappings["b"] = {
	name = "Buffers",
	c = { "<cmd>BufferClose!<CR>", "Close Buffer" },
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
}
lvim.builtin.which_key.mappings["g"] = {
	name = "Git",
	b = { "<cmd>Telescope git_branches<CR>", "Branches" },
	c = { "<cmd>Telescope git_commits<CR>", "Commit" },
	s = { "<Cmd>Telescope git_status<CR>", "Status" },
	l = { "<Cmd>Telescope git_stash<CR>", "Stash" },
}
lvim.builtin.which_key.mappings["q"] = {
	name = "Quit",
	q = { "<cmd>:qa<CR>", "Quit" },
	["!"] = { "<cmd>:qa!<CR>", "Quit without saving" },
}
lvim.builtin.which_key.mappings["P"] = {
	name = "Project",
	w = { ":Telescope file_browser cwd=~/work<CR>", "Browse ~/work" },
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
		"<cmd>lua vim.diagnostic.goto_next()<cr>",
		"Next Diagnostic",
	},
	k = {
		"<cmd>lua vim.diagnostic.goto_prev()<cr>",
		"Prev Diagnostic",
	},
	p = {
		name = "Peek",
		d = { "<cmd>lua require('lsp.peek').Peek('definition')<CR>", "Definition" },
		t = { "<cmd>lua require('lsp.peek').Peek('typeDefinition')<CR>", "Type Definition" },
		i = { "<cmd>lua require('lsp.peek').Peek('implementation')<CR>", "Implementation" },
	},
	r = { "<cmd>TroubleToggle lsp_references<CR>", "References" },
	q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
	R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
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
lvim.builtin.dashboard.custom_section.a.command =
	"Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings"
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

-- *
-- LSP
-- *
lvim.lsp.diagnostics.virtual_text = false

-- Telescope
-- *
lvim.builtin.telescope.active = true
lvim.builtin.telescope.defaults.layout_config.width = 0.95
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git", ".cache", "node_modules", "vendor" }
lvim.builtin.telescope.defaults.mappings = (function()
	local actions = require("telescope.actions")
	local trouble = require("trouble.providers.telescope")
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

lvim.plugins = {
	{ "lunarvim/colorschemes" },
	{
		"folke/tokyonight.nvim",
		config = function()
			require("user.tokyonight").config()
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
		"f-person/git-blame.nvim",
		event = "BufRead",
		config = function()
			require("user.gitblame").config()
		end,
	},
	{
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("user.trouble").config()
		end,
	},
	{
		"monaqa/dial.nvim",
		event = "BufRead",
		config = function()
			require("user.dial").config()
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
	{ "npxbr/glow.nvim", cmd = "Glow" },
	{
		"ggandor/lightspeed.nvim",
		event = "BufReadPost",
		config = function()
			require("user.lightspeed")
		end,
	},
	{ "p00f/nvim-ts-rainbow", event = "BufRead" },
}
