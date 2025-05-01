return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  -- modicator (auto color line number based on vim mode)
  {
    "mawkler/modicator.nvim",
    dependencies = "scottmckendry/cyberdream.nvim",
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = false
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    opts = {},
  },
}
