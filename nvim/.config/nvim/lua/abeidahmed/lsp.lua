return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		-- Mason must be loaded before its dependents so we need to set it up here.
		-- NOTE: `opts = {}` is the same as calling `require("mason").setup({})`
		{ "mason-org/mason.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		{ "j-hui/fidget.nvim", opts = {} },

		-- Allows extra capabilities provided by blink.cmp
		"saghen/blink.cmp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("abeidahmed-lsp-attach", { clear = true }),
			callback = function(event)
				-- We create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Neovim 0.11+ ships default LSP maps on attach: K (hover), grn (rename),
				-- grr (references), gra (code action), gri (implementation), grt (type
				-- definition), gO (document symbols), <C-s> (signature help, insert mode).
				-- We only add what isn't covered by a default (or where we prefer our own).
				map("<space>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
				map("<space>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
			end,
		})

		-- Diagnostic config
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = false,
		})

		-- LSP servers and clients communicate which features they support.
		--  By default, Neovim doesn't support everything in the LSP specification.
		--  blink.cmp adds *more* capabilities (e.g. richer completion), so we broadcast
		--  those to every server via the "*" pseudo-config below.
		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		-- Per-server overrides. nvim-lspconfig ships sane `lsp/<server>.lua` defaults for
		-- each of these, so we only override where the default isn't enough.
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
				},
			},
		})

		-- Use vtsls instead of ts_ls for better Vue 3 support. The default filetypes omit
		-- vue, and the Vue global plugin must be wired into tsserver.
		vim.lsp.config("vtsls", {
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
			settings = {
				vtsls = {
					tsserver = {
						globalPlugins = {
							{
								name = "@vue/typescript-plugin",
								location = vim.fn.stdpath("data")
									.. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
								languages = { "vue" },
								configNamespace = "typescript",
								enableForWorkspaceTypeScriptVersions = true,
							},
						},
					},
				},
			},
		})

		-- ruby-lsp comes from rbenv, not mason. The default lsp/ruby_lsp.lua already sets
		-- cmd, filetypes ({"ruby","eruby"}), root_markers and formatter="auto"; we only need
		-- to silence the Rails pending-migrations prompt.
		-- See: https://shopify.github.io/ruby-lsp/editors.html#built-in-vimlsp
		vim.lsp.config("ruby_lsp", {
			init_options = {
				addonSettings = {
					["Ruby LSP Rails"] = {
						enablePendingMigrationsPrompt = false,
					},
				},
			},
		})

		-- vue_ls, eslint, cssls and gopls run with nvim-lspconfig's defaults.
		local servers = { "lua_ls", "vtsls", "vue_ls", "eslint", "cssls", "gopls", "ruby_lsp" }

		-- mason installs the server binaries (vim.lsp.enable only launches what's on PATH).
		-- ruby_lsp is excluded here because it resolves from rbenv, not mason.
		require("mason-tool-installer").setup({
			ensure_installed = { "lua_ls", "vtsls", "vue_ls", "eslint", "cssls", "gopls", "stylua" },
		})

		-- mason-lspconfig stays only as the lspconfig->mason name-mapper used by
		-- mason-tool-installer. We enable servers ourselves, so turn off its auto-enable.
		require("mason-lspconfig").setup({ automatic_enable = false })

		vim.lsp.enable(servers)
	end,
}
