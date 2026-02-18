local MiniClue = require("mini.clue")
MiniClue.setup({
	-- Define which clues to show. By default shows only clues for custom mappings
	-- (uses `desc` field from the mapping; takes precedence over custom clue).
	clues = {
		MiniClue.gen_clues.builtin_completion(),
		MiniClue.gen_clues.g(),
		MiniClue.gen_clues.marks(),
		MiniClue.gen_clues.registers(),
		MiniClue.gen_clues.square_brackets(),
		MiniClue.gen_clues.windows({ submode_resize = true }),
		MiniClue.gen_clues.z(),
	},
	-- Explicitly opt-in for set of common keys to trigger clue window
	triggers = {
		{ mode = { "n", "x" }, keys = "<Leader>" }, -- Leader triggers
		{ mode = { "n", "x" }, keys = "[" }, -- mini.bracketed
		{ mode = { "n", "x" }, keys = "]" },
		{ mode = "i", keys = "<C-x>" }, -- Built-in completion
		{ mode = { "n", "x" }, keys = "g" }, -- `g` key
		{ mode = { "n", "x" }, keys = "'" }, -- Marks
		{ mode = { "n", "x" }, keys = "`" },
		{ mode = { "n", "x" }, keys = '"' }, -- Registers
		{ mode = { "i", "c" }, keys = "<C-r>" },
		{ mode = "n", keys = "<C-w>" }, -- Window commands
		{ mode = { "n", "x" }, keys = "s" }, -- `s` key (mini.surround, etc.)
		{ mode = { "n", "x" }, keys = "z" }, -- `z` key
	},
})
