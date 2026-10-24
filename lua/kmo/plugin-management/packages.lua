---@param path string
local function cb(path)
  return "https://codeberg.org/" .. path
end

---@param path string
local function gh(path)
  return "https://github.com/" .. path
end

vim.opt.packpath:append(
  vim.fs.normalize(vim.fs.joinpath(vim.fn.stdpath "data", "site"))
)

local names = {
  mason = "mason.nvim",
  treesitter = "nvim-treesitter",
}

local augroup = vim.api.nvim_create_augroup("kmo.pack.build", {})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build mason.nvim",
  group = augroup,
  callback = function(event)
    --- @type vim.event.packchanged.data
    local data = event.data
    local name, kind = data.spec.name, data.kind

    if name ~= names.mason or (kind ~= "install" and kind ~= "update") then
      return
    end

    local has_reg, reg = pcall(require, "mason-registry")

    if not has_reg then
      return
    end

    local id = "mason_nvim_registry_refresh"
    local title = "mason.nvim"

    local symbols = require "kmo.symbols"

    vim.notify("Refreshing registries…", vim.log.levels.INFO, {
      id = id,
      timeout = false,
      title = title,
      opts = function(notification)
        notification.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    reg.refresh(function(success, updated_registries)
      if success then
        vim.notify(
          #updated_registries > 0
              and string.format(
                "Successfully refreshed %d registries.",
                #updated_registries
              )
            or "No registries needed refreshing.",
          vim.log.levels.INFO,
          {
            id = id,
            icon = symbols.progress.done,
            title = title,
          }
        )

        local mason_utils = require "kmo.plugin-management.mason-utils"
        mason_utils.install_packages(mason_utils.always_install)
      else
        vim.notify("Could not refresh the registries.", vim.log.levels.ERROR, {
          id = id,
          title = title,
        })
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Build mason.nvim",
  group = augroup,
  callback = function(event)
    --- @type vim.event.packchanged.data
    local data = event.data
    local active, name, kind = data.active, data.spec.name, data.kind

    if name ~= names.treesitter or (kind ~= "install" and kind ~= "update") then
      return
    end

    if not active then
      vim.cmd.packadd "nvim-treesitter"
    end

    local id = "nvim-treesitter update"
    local title = "nvim-treesitter update"
    local symbols = require "kmo.symbols"

    vim.notify("Updating languages.", vim.log.levels.INFO, {
      id = id,
      timeout = false,
      title = title,
      opts = function(notification)
        notification.icon = symbols.progress.get_dynamic_spinner()
      end,
    })
    require("nvim-treesitter").update():await(function()
      vim.notify("Updated languages.", vim.log.levels.INFO, {
        id = id,
        icon = symbols.progress.done,
        title = title,
      })
    end)
  end,
})

vim.pack.add {
  -- cspell:disable
  { src = gh "AckslD/muren.nvim" },

  { src = gh "brenoprata10/nvim-highlight-colors" },

  { src = gh "chrisgrieser/nvim-rulebook" },

  { src = gh "cshuaimin/ssr.nvim" },

  { src = gh "esmuellert/nvim-eslint" },

  { src = gh "folke/neoconf.nvim" },

  { src = gh "folke/snacks.nvim" },

  { src = gh "folke/todo-comments.nvim" },

  { src = gh "godlygeek/tabular" },

  { src = gh "gregorias/coop.nvim" },
  { src = gh "gregorias/coerce.nvim" },

  { src = gh "hat0uma/csvview.nvim" },

  { src = gh "icholy/lsplinks.nvim" },

  { src = gh "jmbuhr/otter.nvim" },

  { src = gh "Kicamon/markdown-table-mode.nvim" },

  { src = gh "kosayoda/nvim-lightbulb" },

  { src = gh "rafamadriz/friendly-snippets" },
  { src = gh "L3MON4D3/LuaSnip" },

  { src = gh "lewis6991/gitsigns.nvim" },

  { src = gh "lukas-reineke/indent-blankline.nvim" },

  { src = gh "luukvbaal/statuscol.nvim" },

  { src = gh "MagicDuck/grug-far.nvim" },

  { name = names.mason, src = gh "mason-org/mason.nvim" },

  { src = gh "MeanderingProgrammer/render-markdown.nvim" },

  { src = gh "jbyuki/one-small-step-for-vimkind" },
  { src = gh "LiadOz/nvim-dap-repl-highlights" },
  { src = gh "lucaSartore/nvim-dap-exception-breakpoints" },
  { src = gh "nvim-neotest/nvim-nio" },
  { src = gh "rcarriga/nvim-dap-ui" },
  { src = gh "theHamsta/nvim-dap-virtual-text" },
  { src = cb "mfussenegger/nvim-dap" },

  { src = cb "mfussenegger/nvim-lint" },

  { src = gh "MoaidHathot/dotnet.nvim" },

  { src = gh "monaqa/dial.nvim" },

  { src = gh "Hoffs/omnisharp-extended-lsp.nvim" },
  { src = cb "mfussenegger/nvim-jdtls" },
  { src = gh "nvim-lua/plenary.nvim" },
  { src = gh "pmizio/typescript-tools.nvim" },
  { src = gh "seblyng/roslyn.nvim" },
  { src = gh "neovim/nvim-lspconfig" },

  { src = gh "SmiteshP/nvim-navic" },
  { src = gh "nvim-lualine/lualine.nvim" },

  { src = gh "nvim-mini/mini.nvim" },

  { src = gh "nvim-treesitter/nvim-treesitter-context" },
  { src = gh "nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
  { src = gh "RRethy/nvim-treesitter-endwise" },
  { src = gh "windwp/nvim-ts-autotag" },
  { name = names.treesitter, src = gh "nvim-treesitter/nvim-treesitter" },

  { src = gh "olrtg/nvim-emmet" },

  { src = gh "rest-nvim/rest.nvim" },

  { src = gh "Bilal2453/luvit-meta" },
  { src = gh "DrKJeff16/wezterm-types" },
  { src = gh "folke/lazydev.nvim" },
  { src = gh "micangl/cmp-vimtex" },
  { src = gh "moyiz/blink-emoji.nvim" },
  { src = gh "mtoohey31/cmp-fish" },
  { src = gh "rcarriga/cmp-dap" },
  { src = gh "ribru17/blink-cmp-spell" },
  { src = gh "saghen/blink.compat" },
  { src = gh "xzbdmw/colorful-menu.nvim" },
  { src = gh "saghen/blink.cmp", version = vim.version.range "^1.10.2" },

  { src = gh "stevearc/conform.nvim" },

  { src = gh "JezerM/oil-lsp-diagnostics.nvim" },
  { src = gh "refractalize/oil-git-status.nvim" },
  { src = gh "stevearc/oil.nvim" },

  { src = gh "stevearc/overseer.nvim" },

  { src = gh "subnut/nvim-ghost.nvim" },

  { src = gh "windwp/nvim-autopairs" },
  -- cspell:enable
}

for _, ft_path in
  ipairs(
    vim.api.nvim_get_runtime_file(
      "lua/kmo/plugin-management/package-configs/*.lua",
      true
    )
  )
do
  loadfile(ft_path)()
end
