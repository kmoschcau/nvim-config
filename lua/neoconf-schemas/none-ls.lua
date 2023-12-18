--- @class NeoconfNoneLsJavaCheckstyle
--- @field file boolean Whether to use file or project wide linting
--- @field config string The file name for the config file XML
--- @field options string | nil Additional options for checkstyle

--- @class NeoconfNoneLsJavaPmd
--- @field dir string The run directory for PMD
--- @field rulesets string The rulesets for PMD, comma-separated
--- @field cache string | nil The cache file path, if used

--- @class NeoconfNoneLsJava
--- @field checkstyle NeoconfNoneLsJavaCheckstyle Checkstyle options
--- @field pmd NeoconfNoneLsJavaPmd PMD options

--- @class NeoconfNoneLs
--- @field java NeoconfNoneLsJava Java specific options

local checkstyle_default_config = "/google_checks.xml"

local pmd_default_dir = "$ROOT"
local pmd_default_rulesets = "category/java/bestpractices.xml"

return {
  --- @type NeoconfNoneLs
  defaults = {
    java = {
      checkstyle = {
        file = false,
        config = checkstyle_default_config,
        options = nil,
      },
      pmd = {
        dir = pmd_default_dir,
        rulesets = pmd_default_rulesets,
        cache = nil,
      },
    },
  },
  schema = {
    java = {
      type = "object",
      description = "Java specific options",
      additionalProperties = false,
      properties = {
        checkstyle = {
          type = "object",
          description = "Checkstyle options",
          additionalProperties = false,
          properties = {
            file = {
              type = "boolean",
              description = "Whether to use file or project wide linting",
              default = false,
            },
            config = {
              type = { "string" },
              description = "The file name for the config file XML",
              default = checkstyle_default_config,
            },
            options = {
              type = { "string", "null" },
              description = "Additional options for checkstyle",
            },
          },
        },
        pmd = {
          type = "object",
          description = "PMD options",
          additionalProperties = false,
          properties = {
            dir = {
              type = { "string" },
              description = "The run directory for PMD",
              default = pmd_default_dir,
            },
            rulesets = {
              type = { "string" },
              description = "The rulesets for PMD",
              default = pmd_default_rulesets,
            },
            cache = {
              type = { "string", "null" },
              description = "The cache file path, if used",
            },
          },
        },
      },
    },
  },
}
