-- Neovim Configuration Entry Point
-- Enkel och ren konfiguration med Lazy.nvim

-- Ladda grundläggande inställningar
require("config.options")
require("config.keymaps")
require("config.lazy")

-- TODO:
-- [ ] lägga till session memory so i can enter where i left
-- [X] fixa så jag enkelt kan öppna en terminal
--      [ ] kankse göra så att man kan öppna ny terminal också beroende på hur lätt det är
