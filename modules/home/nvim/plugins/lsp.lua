local lspconfig = vim.lsp

lspconfig.enable("bashls")
lspconfig.enable("biome")
lspconfig.enable("marksman")
lspconfig.enable("stylelint_lsp")
lspconfig.enable("ts_ls")
lspconfig.enable("yamlls")
lspconfig.config("nil_ls", {
	autostart = true,
	capabilities = caps,
	settings = {
		["nil"] = {
			nix = {
				autoEvalInputs = true,
			},
		},
	},
})
