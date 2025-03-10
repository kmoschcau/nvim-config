-- NOTE: This is only kept for nvim-dap's C# debugging selects.

-- selene: allow(mixed_table)
--- @type LazyPluginSpec
return {
  "nvim-telescope/telescope.nvim",
  lazy = true,
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require "telescope"
    local actions = require "telescope.actions"

    local default_picker_settings = { theme = "ivy" }

    telescope.setup {
      defaults = {
        mappings = {
          i = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-S>"] = actions.select_horizontal,
            ["<C-X>"] = false,
          },
          n = {
            ["<C-Down>"] = actions.cycle_history_next,
            ["<C-Up>"] = actions.cycle_history_prev,
            ["<C-S>"] = actions.select_horizontal,
            ["<C-X>"] = false,
          },
        },
        path_display = { "smart" },
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--engine=auto",
        },
      },
      pickers = {
        live_grep = vim.tbl_extend("force", default_picker_settings, {
          mappings = {
            i = {
              ["<C-f>"] = actions.to_fuzzy_refine,
            },
          },
        }),
        grep_string = default_picker_settings,
        find_files = default_picker_settings,
        fd = default_picker_settings,
        treesitter = default_picker_settings,
        current_buffer_fuzzy_find = default_picker_settings,
        tags = default_picker_settings,
        current_buffer_tags = default_picker_settings,
        git_files = default_picker_settings,
        git_commits = default_picker_settings,
        git_bcommits = default_picker_settings,
        git_branches = default_picker_settings,
        git_status = default_picker_settings,
        git_stash = default_picker_settings,
        builtin = default_picker_settings,
        resume = default_picker_settings,
        pickers = default_picker_settings,
        planets = default_picker_settings,
        symbols = default_picker_settings,
        commands = default_picker_settings,
        quickfix = default_picker_settings,
        quickfixhistory = default_picker_settings,
        loclist = default_picker_settings,
        oldfiles = default_picker_settings,
        command_history = default_picker_settings,
        search_history = default_picker_settings,
        vim_options = default_picker_settings,
        help_tags = default_picker_settings,
        man_pages = default_picker_settings,
        reloader = default_picker_settings,
        buffers = default_picker_settings,
        colorscheme = default_picker_settings,
        marks = default_picker_settings,
        registers = default_picker_settings,
        keymaps = default_picker_settings,
        filetypes = default_picker_settings,
        highlights = default_picker_settings,
        autocommands = default_picker_settings,
        spell_suggest = default_picker_settings,
        tag_stack = default_picker_settings,
        jumplist = default_picker_settings,
        lsp_references = vim.tbl_extend("force", default_picker_settings, {
          include_declaration = false,
        }),
        lsp_incoming_calls = default_picker_settings,
        lsp_outgoing_calls = default_picker_settings,
        lsp_definitions = default_picker_settings,
        lsp_type_definitions = default_picker_settings,
        lsp_implementations = default_picker_settings,
        lsp_document_symbols = default_picker_settings,
        lsp_workspace_symbols = default_picker_settings,
        lsp_dynamic_workspace_symbols = default_picker_settings,
        diagnostics = default_picker_settings,
      },
    }
  end,
}
