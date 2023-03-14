local ehandler = require("error-handler").handler

-- neodev has to be set up before lspconfig
xpcall(require, ehandler, "plugins.config.neodev")

xpcall(require, ehandler, "plugins.config.cmp")
xpcall(require, ehandler, "plugins.config.colorizer")
xpcall(require, ehandler, "plugins.config.dap")
xpcall(require, ehandler, "plugins.config.dapui")
xpcall(require, ehandler, "plugins.config.dressing")
xpcall(require, ehandler, "plugins.config.editing")
xpcall(require, ehandler, "plugins.config.gitsigns")
xpcall(require, ehandler, "plugins.config.lsp")
xpcall(require, ehandler, "plugins.config.lsp.omnisharp")
xpcall(require, ehandler, "plugins.config.lualine")
xpcall(require, ehandler, "plugins.config.mason")
xpcall(require, ehandler, "plugins.config.notify")
xpcall(require, ehandler, "plugins.config.null-ls")
xpcall(require, ehandler, "plugins.config.telescope")
xpcall(require, ehandler, "plugins.config.treesitter")
xpcall(require, ehandler, "plugins.config.tree")

-- mason-lspconfig has to be set up after lspconfig
xpcall(require, ehandler, "plugins.config.mason-lspconfig")
-- mason-null-ls has to be set up after null-ls
xpcall(require, ehandler, "plugins.config.mason-null-ls")
-- mason-nvim-dap has to be set up after nvim-dap
xpcall(require, ehandler, "plugins.config.mason-nvim-dap")
