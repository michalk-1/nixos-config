return {
  {
    "folke/snacks.nvim",
    -- priority = 1000,
    -- lazy = false,
    -- ---@type snacks.Config
    opts = {
      picker = {
        hidden = true, -- for hidden files
        -- ignored = true, -- for .gitignore files
        enabled = true,
        file_ignore_patterns = { "node_modules" },
        sources = {
          files = {
            hidden = true,
            -- ignored = true,
            file_ignore_patterns = { "node_modules" },
          },
          explorer = {
            hidden = true,
            ignored = true,
            layout = { layout = { position = "right" } },
            file_ignore_patterns = { "node_modules" },
          },
        },
      },

      -- notifier = { enabled = true },
      -- quickfile = { enabled = true },
      -- scope = { enabled = true },
      -- scroll = { enabled = true },
      -- statuscolumn = { enabled = true },
      -- words = { enabled = true },
    },
  },
}