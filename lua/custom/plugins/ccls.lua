local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('lspconfig').ccls.setup {
	cmd = {"/opt/ccls"},
	init_options = {
		index = {
			threads = 16;
		};
	},
	capabilities = capabilities,
}

print('Setting up ccls')
return {}
