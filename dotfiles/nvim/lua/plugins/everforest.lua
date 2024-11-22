return {
	"neanias/everforest-nvim",
  version = false,
  lazy = false,
	name = "everforest",
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("everforest")
		local everforest = require("everforest")
		everforest.setup({
			italics = true,
			disable_italic_comments = false,
      transparent_background_level = 1,
		})
	end,
}
