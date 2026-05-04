-- Neovim Configuration Entry Point
-- Enkel och ren konfiguration med Lazy.nvim

-- Minimum version guard: abort early with a clear message instead of
-- crashing silently if Neovim is too old for this config.
if vim.fn.has("nvim-0.12") == 0 then
    vim.notify(
        "This config requires Neovim 0.12+. Current: " .. tostring(vim.version()),
        vim.log.levels.ERROR
    )
    return
end

-- Safe loader: wraps require() in pcall so a broken module prints a clear
-- error and lets the rest of the config continue loading.
local function safe_require(mod)
    local ok, err = pcall(require, mod)
    if not ok then
        vim.notify("Failed to load '" .. mod .. "':\n" .. tostring(err), vim.log.levels.ERROR)
    end
end

-- Ladda grundläggande inställningar
safe_require("config.options")
safe_require("config.keymaps")
safe_require("config.lazy")

-- TODO:
-- [ ] lägga till session memory so i can enter where i left
-- [X] fixa så jag enkelt kan öppna en terminal
--      [ ] kankse göra så att man kan öppna ny terminal också beroende på hur lätt det är
