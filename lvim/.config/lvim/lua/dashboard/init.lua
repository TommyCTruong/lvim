lvim.builtin.alpha.dashboard.section.header = {
  type = "text",
  val = {
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
  },
  opts = {
    position = "center",
    hl = "Label",
  },
}

lvim.builtin.alpha.dashboard.section.buttons = {
  entries = {
    { "SPC f", "  Find File", "<CMD>Telescope find_files find_command=rg,--ignore,--hidden,--files,--fixed-strings<CR>" },
    { "SPC n", "  New File", "<CMD>ene!<CR>" },
    { "SPC P", "  Recent Projects ", "<CMD>Telescope projects<CR>" },
    { "SPC s r", "  Recently Used Files", "<CMD>Telescope oldfiles<CR>" },
    { "SPC s t", "  Find Word", "<CMD>Telescope live_grep vimgrep_arguments=rg,--color=never,--no-heading,--hidden,--with-filename,--line-number,--column,--smart-case,--fixed-strings,--multiline<CR>" },
    {
      "SPC L c",
      "  Configuration",
      "<CMD>edit " .. require("lvim.config").get_user_config_path() .. " <CR>",
    },
  },
}
