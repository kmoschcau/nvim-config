return {
  -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
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
        memoryLayout = {
          niches = true,
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
          enable = "always",
        },
        closureStyle = "impl_fn",
        discriminantHints = {
          enable = "always",
        },
        expressionAdjustmentHints = {
          enable = "always",
        },
        implicitDrops = {
          enable = true,
        },
        lifetimeElisionHints = {
          enable = "always",
          useParameterNames = true,
        },
        rangeExclusiveHints = {
          enable = true,
        },
      },
      lens = {
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
      notifications = {
        unindexedProject = true,
      },
      rustfmt = {
        rangeFormatting = {
          enable = true,
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
