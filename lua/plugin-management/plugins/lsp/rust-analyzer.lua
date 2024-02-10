local common = require "lsp.common"
local lspconfig = require "lspconfig"

lspconfig.rust_analyzer.setup {
  capabilities = common.capabilities,
  handlers = common.handlers,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        emitMustUse = true,
      },
      completion = {
        fullFunctionSignatures = {
          enable = true,
        },
      },
      hover = {
        actions = {
          references = {
            enable = true,
          },
        },
      },
      inlayHints = {
        bindingModeHints = {
          enable = true,
        },
        closureCaptureHints = {
          enable = true,
        },
        closureReturnTypeHints = {
          enable = "never", -- TODO: Figure out other values
        },
        closureStyle = "impl_fn", -- TODO: Figure out other values
        discriminantHints = {
          enable = "never", -- TODO: Figure out other values
        },
        expressionAdjustmentHints = {
          enable = "never", -- TODO: Figure out other values
          hideOutsideUnsafe = false,
          mode = "prefix",
        },
        implicitDrops = {
          enable = true,
        },
        lifetimeEllisionHints = {
          enable = "never", -- TODO: Figure out other values
          useParameterNames = true,
        },
        rangeExclusiveHints = {
          enable = true,
        },
        reborrowHints = {
          enable = "never", -- TODO: Figure out other values
        },
      },
      lens = {
        -- TODO: Figure out other values, likely no effect in neovim.
        location = "above_name",
        references = {
          adt = {
            enable = true,
          },
          enumVariant = {
            enable = true,
          },
          method = {
            enable = true,
          },
          trait = {
            enable = true,
          },
        },
      },
      semanticHighlighting = {
        operator = {
          specialization = {
            enable = true,
          },
        },
        punctuation = {
          enable = true,
          separate = {
            macro = {
              bang = true,
            },
          },
          specialization = {
            enable = true,
          },
        },
      },
      -- Likely won't work in neovim.
      typing = {
        autoClosingAngleBrackets = {
          enable = true,
        },
      },
    },
  },
}
