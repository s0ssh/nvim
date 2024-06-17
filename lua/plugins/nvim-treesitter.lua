-- treesitter -------------------------------------

return {
	'nvim-treesitter/nvim-treesitter',
	build = function()
		pcall(require('nvim-treesitter.install').update { with_sync = true })
	end,
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects'
	},
	config = function()
		require('nvim-treesitter.configs').setup {
			ensure_installed = {
				'c', 'rust', 'lua'
			},
			sync_install = false,
			auto_install = true,
			highlight = {
				-- `false` will disable the whole extension
				enable = true,

				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
				-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
				-- Using this option may slow down your editor, and you may see some duplicate highlights.
				-- Instead of true it can also be a list of languages
				additional_vim_regex_highlighting = false,
			},
		}
	end
}




