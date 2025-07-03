-- Neovim Options
-- Grundläggande inställningar för Neovim

local opt = vim.opt

-- Utseende
opt.number = true           -- Visa radnummer
opt.relativenumber = true   -- Relativa radnummer
opt.cursorline = true       -- Markera aktuell rad
opt.termguicolors = true    -- 24-bit färger
opt.signcolumn = "yes"      -- Visa signkolumn alltid

-- Indentation
opt.tabstop = 4             -- Antal spaces för en tab
opt.shiftwidth = 4          -- Antal spaces för auto-indentation
opt.expandtab = true        -- Använd spaces istället för tabs
opt.autoindent = true       -- Automatisk indentation
opt.smartindent = true      -- Smart indentation

-- Sökning
opt.ignorecase = true       -- Ignorera case vid sökning
opt.smartcase = true        -- Case-sensitive om söksträngen innehåller stora bokstäver
opt.hlsearch = false        -- Highlighta sökresultat
opt.incsearch = true        -- Inkrementell sökning

-- Redigering
opt.wrap = false            -- Ingen radbrytning
opt.scrolloff = 8           -- Håll 8 rader synliga ovanför/under cursor
opt.sidescrolloff = 8       -- Håll 8 kolumner synliga vid sidan av cursor

-- Filhantering
opt.backup = false          -- Ingen backup
opt.swapfile = false        -- Ingen swapfile
opt.undofile = true         -- Persistent undo

-- Prestanda
opt.updatetime = 250        -- Snabbare completion
opt.timeoutlen = 300        -- Snabbare timeout för keymaps

-- Clipboard
opt.clipboard = "unnamedplus" -- Använd systemklippbordet
