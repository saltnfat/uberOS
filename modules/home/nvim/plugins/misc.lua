local bufferline = require("bufferline")
bufferline.setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return icon .. count
		end,
		style_preset = bufferline.style_preset.minimal,
	},
})

require("auto-session").setup({})
require("flash").setup({
	modes = { search = { enabled = true } },
})
require("gitsigns").setup()
require("ibl").setup()
require("lsp_lines").setup()
require("mini.files").setup()
-- require("mini.pairs").setup()
require("mini.surround").setup()

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
	virtual_text = false,
})

require("minuet").setup({
	provider = "openai_fim_compatible",
	n_completions = 1, -- recommend for local model for resource saving
	-- I recommend beginning with a small context window size and incrementally
	-- expanding it, depending on your local computing power. A context window
	-- of 512, serves as an good starting point to estimate your computing
	-- power. Once you have a reliable estimate of your local computing power,
	-- you should adjust the context window to a larger value.
	context_window = 512,
	provider_options = {
		openai_fim_compatible = {
			-- For Windows users, TERM may not be present in environment variables.
			-- Consider using APPDATA instead.
			api_key = "TERM",
			name = "Ollama",
			-- end_point = "http://localhost:11434/v1/completions",
			-- 192.168.187.1 is the ip of the host machine if serving ollama from a host machine and current machine is a dev vm using vmware
			end_point = "http://192.168.187.1:11434/v1/completions",
			model = "qwen2.5-coder:1.5b",
			optional = {
				max_tokens = 56,
				top_p = 0.9,
			},
		},
	},
	virtualtext = {
		auto_trigger_ft = {},
		keymap = {
			-- accept whole completion
			accept = "<A-A>",
			-- accept one line
			accept_line = "<A-a>",
			-- accept n lines (prompts for number)
			-- e.g. "A-z 2 CR" will accept 2 lines
			accept_n_lines = "<A-z>",
			-- Cycle to prev completion item, or manually invoke completion
			prev = "<A-[>",
			-- Cycle to next completion item, or manually invoke completion
			next = "<A-]>",
			dismiss = "<A-e>",
		},
	},
})

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

require("nvim-autopairs").setup({})

require("nvim-treesitter").setup({
	ensure_installed = {},
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
})

require("outline").setup({})

require("snacks").setup({

	animate = { enabled = true },
	bigfile = { enabled = true },
	bufdelete = { enabled = true },
	dim = { enabled = true },
	image = {
		enabled = true,
		doc = {
			inline = true,
			float = true,
		},
	},
	scroll = { enabled = true },
	zen = { enabled = true },
})
require("tailwind-tools").setup({})
require("trouble").setup({
	win = {
		wo = {
			wrap = true,
		},
	},
})

require("wtf").setup({
	popup_type = "popup",
	provider = "ollama",
	providers = {
		ollama = {
			url = "http://192.168.187.1:11434/v1/chat/completions",
			model_id = "devstral:latest",
		},
	},
	language = "english",
	additional_instructions = "Start the reply with 'OH HAI THERE'",
	search_engine = "duck_duck_go",
	hooks = {
		request_started = nil,
		request_finished = nil,
	},
})
