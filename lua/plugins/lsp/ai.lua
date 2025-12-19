return {
	"huggingface/llm.nvim",
	opt = {
		backend = "ollama",
		model = "codellama:7b",
		url = "http://localhost:11434", -- llm-ls uses "/api/generate"
		request_body = {},
		fim = {
			enabled = true,
			prefix = "<fim_prefix>",
			middle = "<fim_middle>",
			suffix = "<fim_suffix>",
		},
		debounce_ms = 150,
		accept_keymap = "<Tab>",
		dismiss_keymap = "<S-Tab>",
	},
}
