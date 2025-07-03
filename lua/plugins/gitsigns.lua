-- Gitsigns Git Integration Plugin
-- Visar git-ändringar direkt i editorn med tecken i vänstermarginalen
--
-- Funktioner:
-- - Visar vilka rader som har lagts till, ändrats eller tagits bort
-- - Colored signs i signcolumn för olika typer av ändringar
-- - Hunk navigation för att hoppa mellan ändringar
-- - Stage/unstage individual hunks direkt från editorn
-- - Inline blame information för att se vem som ändrade vad
-- - Preview av ändringar i popup-fönster
-- - Integration med Neovims diagnostics system
-- - Automatisk uppdatering när filer ändras
--
-- Tecken som visas:
-- - │ : Rader som lagts till (grön)
-- - │ : Rader som ändrats (blå/gul)
-- - _ : Rader som tagits bort (röd)
-- - ‾ : Rader som tagits bort överst (röd)
-- - ~ : Rader som både ändrats och tagits bort (röd)
-- - ┆ : Rader som inte är trackade av git (grå)
--
-- Användning:
-- - Hovra över tecken för att se mer information
-- - Använd ]c och [c för att navigera mellan ändringar
-- - :Gitsigns preview_hunk för att se ändring i popup

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Ladda när fil öppnas
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
    })
  end,
}
