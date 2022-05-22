local util = require("util")

-- Reset all defaults except "e" (explorer) and "/" (comment).
lvim.builtin.which_key.mappings["g"] = nil -- Git
lvim.builtin.which_key.mappings[";"] = nil -- Dashboard
lvim.builtin.which_key.mappings["h"] = nil -- No highlight
lvim.builtin.which_key.mappings["q"] = nil -- Quit
lvim.builtin.which_key.mappings["w"] = nil -- Save
lvim.builtin.which_key.mappings["b"] = nil -- Buffer
lvim.builtin.which_key.mappings["l"] = nil -- LSP
lvim.builtin.which_key.mappings["s"] = nil -- Search
lvim.builtin.which_key.mappings["T"] = nil -- Treesitter
lvim.builtin.which_key.mappings["L"] = nil -- LunarVim
lvim.builtin.which_key.mappings["p"] = nil -- Packer
lvim.builtin.which_key.mappings["c"] = nil -- Close buffer
lvim.builtin.which_key.mappings["f"] = nil -- Find file

-- Editor
lvim.builtin.which_key.mappings["x"] = {
  name = "Editor",
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    r = { "<cmd>lua require('lvim.plugin-loader').recompile()<cr>", "Re-compile" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  L = {
    name = "+LunarVim",
    c = {
      "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>",
      "Edit config.lua",
    },
    f = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').find_lunarvim_files()<cr>",
      "Find LunarVim files",
    },
    g = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').grep_lunarvim_files()<cr>",
      "Grep LunarVim files",
    },
    k = { "<cmd>Telescope keymaps<cr>", "View LunarVim's keymappings" },
    i = {
      "<cmd>lua require('lvim.core.info').toggle_popup(vim.bo.filetype)<cr>",
      "Toggle LunarVim Info",
    },
    I = {
      "<cmd>lua require('lvim.core.telescope.custom-finders').view_lunarvim_changelog()<cr>",
      "View LunarVim's changelog",
    },
    l = {
      name = "+logs",
      d = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(require('lvim.core.log').get_path())<cr>",
        "view default log",
      },
      D = {
        "<cmd>lua vim.fn.execute('edit ' .. require('lvim.core.log').get_path())<cr>",
        "Open the default logfile",
      },
      l = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(vim.lsp.get_log_path())<cr>",
        "view lsp log",
      },
      L = { "<cmd>lua vim.fn.execute('edit ' .. vim.lsp.get_log_path())<cr>", "Open the LSP logfile" },
      n = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view(os.getenv('NVIM_LOG_FILE'))<cr>",
        "view neovim log",
      },
      N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
      p = {
        "<cmd>lua require('lvim.core.terminal').toggle_log_view('packer.nvim')<cr>",
        "view packer log",
      },
      P = { "<cmd>exe 'edit '.stdpath('cache').'/packer.nvim.log'<cr>", "Open the Packer logfile" },
    },
    r = { "<cmd>LvimReload<cr>", "Reload LunarVim's configuration" },
    u = { "<cmd>LvimUpdate<cr>", "Update LunarVim" },
  },
  T = {
    name = "Treesitter",
    i = { ":TSConfigInfo<cr>", "Info" },
  },
}

-- Help
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

-- Buffer
lvim.builtin.which_key.mappings["b"] = {
  name = "Buffers",
  c = { "<cmd>BufferKill<CR>", "Close" },
  j = { "<cmd>BufferLinePick<cr>", "Jump" },
  f = { "<cmd>Telescope buffers<cr>", "Find" },
  b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
  e = {
    "<cmd>BufferLinePickClose<cr>",
    "Pick which buffer to close",
  },
  h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
  l = {
    "<cmd>BufferLineCloseRight<cr>",
    "Close all to the right",
  },
  D = {
    "<cmd>BufferLineSortByDirectory<cr>",
    "Sort by directory",
  },
  L = {
    "<cmd>BufferLineSortByExtension<cr>",
    "Sort by language",
  },
}

-- Quit
lvim.builtin.which_key.mappings["q"] = {
  name = "Quit",
  q = { "<cmd>:qa<CR>", "Quit" },
  ["!"] = { "<cmd>:qa!<CR>", "Quit without saving" },
}

-- Search
lvim.builtin.which_key.mappings["s"] = {
  name = "Search",
  p = { ":Telescope projects<CR>", "Projects" },
  f = {
    "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings<CR>",
    "Files",
  },
  g = { "<cmd>Telescope git_files<CR>", "Git files" },
  b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current buffer" },
  t = {
    "<cmd>Telescope live_grep vimgrep_arguments=rg,--color=never,--no-heading,--hidden,--with-filename,--line-number,--column,--smart-case,--fixed-strings,--multiline<CR>",
    "Text",
  },
  c = {
    "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<CR>",
    "Colorscheme with preview",
  },
  m = { "<cmd>Telescope marks<CR>", "Marks" },
  h = { "<cmd>Telescope help_tags<CR>", "Help" },
  M = { "<cmd>Telescope man_pages<CR>", "Man pages" },
  r = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
  R = { "<cmd>Telescope registers<CR>", "Registers" },
}


-- LSP
lvim.builtin.which_key.mappings["l"] = {
  name = "LSP",
  a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
  r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<CR>", "Buffer diagnostics" },
  w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
  f = { "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", "Format" },
  I = { "<cmd>lua require('lspfuncs').implementation()<CR>", "Implementation" },
  j = {
    "<cmd>lua vim.diagnostic.goto_next()<cr>",
    "Next diagnostic",
  },
  k = {
    "<cmd>lua vim.diagnostic.goto_prev()<cr>",
    "Prev diagnostic",
  },
  p = {
    name = "Peek",
    d = { "<cmd>lua require('lvim.lsp.peek').Peek('definition')<cr>", "Definition" },
    t = { "<cmd>lua require('lvim.lsp.peek').Peek('typeDefinition')<cr>", "Type definition" },
    i = { "<cmd>lua require('lvim.lsp.peek').Peek('implementation')<cr>", "Implementation" },
  },
  S = {
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "Workspace Symbols",
  },
  e = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
  x = {
    name = "Info",
    x = { "<cmd>LspInfo<CR>", "LSP" },
    i = { "<cmd>LspInstallInfo<CR>", "Installer" },
  },
}

lvim.builtin.which_key.mappings["g"] = {
  name = "Git",
  o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  d = {
    "<cmd>Gitsigns diffthis HEAD<cr>",
    "Git diff",
  },
  l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
}

lvim.builtin.which_key.mappings["t"] = {
  name = "Toggle",
  h = {
    function()
      util.toggle("hlsearch")
    end,
    "Highlight",
  },
  n = {
    function()
      util.toggle("relativenumber", true)
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
  x = {
    function()
      local vscode = require('vscode')
      if vim.g.vscode_style == "dark" then
        vscode.change_style("light")
      else
        vscode.change_style("dark")
      end
    end,
    "Colorscheme"
  }
}

-- ene! new file/buffer
