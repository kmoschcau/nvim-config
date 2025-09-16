-- For some reason vim.filetype.get_option gives a different result here, so
-- just set this explicitly.
vim.opt_local.comments =
  { "sO:* -", "mO:*  ", "exO:*/", "s1:/*", "mb:*", "ex:*/", "://" }

require("auto-snippets.ecmascript").register_add_async()
