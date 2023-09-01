local color_table = require("colors.material.utils").color_table

local M = {}

M.hues = {
  -- Hue used for most of the editor background and framing, should be subtle.
  neutral = "grey",

  -- Hue used as the primary accent for currently interacted with elements in
  -- normal mode
  primary = "cyan",

  -- Hue used for insert mode
  insert = "blue",

  -- Hue used for replace mode
  replace = "amber",

  diff = {
    -- Hue used for added diff
    added = "green",

    -- Hue used for changed diff
    changed = "amber",

    -- Hue used for deleted diff
    deleted = "red",

    -- Hue used for text diff
    text = "orange",
  },

  syntax = {
    namespace = "brown",
  },
}

M.indices = {
  syntax = {
    namespace = 4,
  },
}

M.colors = function()
  return {
    neutral = {
      lightest = color_table(M.hues.neutral, 1),
      midpoint = color_table(M.hues.neutral, 5),
      midpoint_strong = color_table(M.hues.neutral, 6),
      strong = color_table(M.hues.neutral, 8),
    },
    interact = {
      light = color_table(M.hues.primary, 2),
    },
    error = {
      light = color_table("red", 3),
      strong = color_table("red", 6),
    },
    warning = {
      light = color_table("orange", 3),
      strong = color_table("orange", 6),
    },
    success = {
      light = color_table("light_green", 3, {
        accent = true,
        invert_dark = false,
      }),
      strong = color_table("light_green", 3, {
        accent = true,
        invert_dark = false,
      }),
    },
    info = {
      light = color_table("light_blue", 3),
      strong = color_table("light_blue", 6),
    },
    debug = {
      light = color_table("grey", 3),
      strong = color_table("grey", 6),
    },
    trace = {
      light = color_table("purple", 3),
      strong = color_table("purple", 6),
    },
    syntax = {
      enum = {
        name = color_table("indigo", 6),
        member = color_table("light_blue", 6),
      },
      ["function"] = color_table("teal", 6),
      meta = {
        light = color_table("purple", 1),
        strong = color_table("purple", 4),
      },
      namespace = color_table(
        M.hues.syntax.namespace,
        M.indices.syntax.namespace
      ),
      number = {
        light = color_table("blue", 1),
      },
      structure = color_table("light_green", 6),
      type = color_table("lime", 6),
      typedef = color_table("green", 6),
    },
  }
end

return M