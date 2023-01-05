local M = {}

M.config = function()
	local null_ls = require("null-ls")
	null_ls.setup({
		on_attach = require("lsp-format").on_attach,
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.alejandra,
			null_ls.builtins.formatting.buf,
			null_ls.builtins.formatting.buildifier,
			null_ls.builtins.formatting.cljstyle,
			null_ls.builtins.formatting.cueimports,
			null_ls.builtins.formatting.cue_fmt,
			null_ls.builtins.formatting.rego,
			null_ls.builtins.formatting.shfmt,
			null_ls.builtins.formatting.taplo,
			null_ls.builtins.formatting.yamlfmt,
			null_ls.builtins.formatting.zigfmt,
			null_ls.builtins.code_actions.gitsigns,
			null_ls.builtins.code_actions.statix,
			null_ls.builtins.diagnostics.selene,
			null_ls.builtins.diagnostics.actionlint,
			null_ls.builtins.diagnostics.buf,
			null_ls.builtins.diagnostics.clj_kondo,
			null_ls.builtins.diagnostics.deadnix,
			null_ls.builtins.diagnostics.dotenv_linter,
			null_ls.builtins.diagnostics.golangci_lint,
			null_ls.builtins.diagnostics.hadolint,
			null_ls.builtins.diagnostics.shellcheck,
			null_ls.builtins.diagnostics.statix,
		},
	})
end

return M
