require("keysettings")
require("dashboard")
require("whichkey")

-- Color scheme
lvim.colorscheme = "vscode"
lvim.builtin.lualine.options.theme = "vscode"

-- Formatting/linting
lvim.format_on_save = true
lvim.lint_on_save = true

-- Notify
lvim.builtin.notify.active = true

-- LSP
lvim.lsp.automatic_servers_installation = true

-- Terminal
lvim.builtin.terminal.active = true
lvim.builtin.terminal.shading_factor = 1
lvim.builtin.terminal.execs = {}

-- NvimTree
lvim.builtin.nvimtree.setup.filters.custom = { ".git", "node_modules", ".cache", "vendor", ".vscode" }

-- Telescope
lvim.builtin.telescope.defaults.file_ignore_patterns = { ".git", ".cache", "node_modules", "vendor", ".vscode" }
lvim.builtin.telescope.defaults.mappings = (function()
	local actions = require("telescope.actions")
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
		},
		n = {
			["<C-j>"] = actions.move_selection_next,
			["<-k>"] = actions.move_selection_previous,
			["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
		},
	}
end)()

lvim.plugins = {
	{
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("setup.scroll").config()
		end,
	},
	{
		"nacro90/numb.nvim",
		event = "BufRead",
		config = function()
			require("setup.numb").config()
		end,
	},
	{
		"andymass/vim-matchup",
		event = "CursorMoved",
		config = function()
			require("setup.matchup").config()
		end,
	},
	{
		"chentoast/marks.nvim",
		config = function()
			require("setup.marks").config()
		end,
	},
	{
		"monaqa/dial.nvim",
		event = "BufRead",
		config = function()
			require("setup.dial").config()
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		config = function()
			local status_ok, vscode = pcall(require, "vscode")
			if not status_ok then
				return
			end
			vscode.change_style("dark")

			lvim.colorscheme = "vscode"
			lvim.builtin.lualine.options.theme = "vscode"
		end,
	},
	{
		"ur4ltz/surround.nvim",
		config = function()
			require("surround").setup({ mappings_style = "surround" })
		end,
	},
}
