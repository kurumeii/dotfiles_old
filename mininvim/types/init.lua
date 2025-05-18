---@class  CspellConfig.dictionaryDefinitions
---@field name string
---@field path string

---@class CspellConfig
---@field dictionaryDefinitions CspellConfig.dictionaryDefinitions[]
---@field dictionaries string[]
---@field words string[]

--- @class MiniLoadSpec
--- @field source string -- Either the git repo or the plugin path
--- @field depends? table<string> -- Table of plugin repos
--- @field hooks? table<string, function> -- Table of hooks
--- @field later? boolean -- Whether to execute later
--- @field cb? function --  Callback function !avoid if possible
--- @field opts? table -- Options to pass to the plugin use with name if module name is not equal to source
--- @field name? string -- Provided a name to use with opts
--- @field disable? boolean -- Whether to disable the plugin
