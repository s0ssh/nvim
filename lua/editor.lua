---------------------------
-- general editor config --
---------------------------

local opt	= vim.opt
local g		= vim.g
local cmd	= vim.cmd
local api	= vim.api

--> set globals
local function set_globals()
	local globals = {
		loaded_netrwPlugin = 1,
		mapleader = ' ',
		maplocalleader = ' ',
	}

	for key, val in pairs(globals) do
		g[key] = val
	end
end


--> set options
local function set_options()
	local options = {
		autoread		= true,
		number			= true,
		relativenumber	= true,
		ruler			= true,
		wrap			= true,
	   	autoindent		= true,
		smartindent		= true,
		hlsearch		= false,
		incsearch		= true,
		tabstop			= 4,
		softtabstop		= 4,
		shiftwidth		= 4,
		mouse			= '',
		updatetime		= 50,
		termguicolors	= true,
		swapfile		= false,
		backup			= false,
		undodir			= os.getenv('HOME') .. '/.nvim/undodir',
		undofile		= true,
		scrolloff		= 8,
		colorcolumn		= '100'
	}

	for key, val in pairs(options) do
		opt[key] = val
	end

	cmd.syntax		'on'
	cmd.filetype	'on'
end


--> set mappings
local function set_mappings()
	local opts = {
		noremap = true,
		silent = true,
	}

	local mappings = {
		-- move blocks
		{'v', 'J', ":m '>+1<CR>gv=gv"},
		{'v', 'K', ":m '<-2<CR>gv=gv"},

		-- placement QoL 
		{'n', 'J', 'mzJ`z'},
		{'n', '<C-d>', '<C-d>zz'},
		{'n', '<C-u>', '<C-u>zz'},
		{'n', 'n', 'nzzzv'},
		{'n', 'N', 'Nzzzv'},

		-- buffer-preserving paste
		{'x', '<leader>p', [['_dP]]},

		-- buffer-preserving delete
		{{'n', 'v'}, '<leader>d', [['_d]]},

		-- system clipboard shortcuts
		{{'n', 'v'}, '<leader>y', [['+y]]},
		{'n', '<leader>Y', [['+Y]]},

		-- vertical mode CTRL-C patch
		{'i', '<C-c>', '<Esc>'},

		-- prevent 'Q' presses
		{'n', 'Q', '<nop>'},

		-- replace the word you're on
		{'n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]},

		-- make current file executable
		{'n', '<leader>x', '<cmd>!chmod +x %<CR>', { silent = true }},

		-- Telescope mappings
		{'n', '<c-space>', '<cmd>Telescope find_files<CR>', opts},
		{'v', '<c-space>', '<cmd>Telescope find_files<CR>', opts},

		-- nvim-tree mappings
		{'n', '<c-a>', '<cmd>NvimTreeToggle<CR>', opts},
		{'v', '<c-a>', '<cmd>NvimTreeToggle<CR>', opts},

		-- tagbar mappings
		{'n', '<c-s>', '<cmd>TagbarToggle<CR>', opts},
		{'v', '<c-s>', '<cmd>TagbarToggle<CR>', opts},

		-- disable arrow keys
	    {'n', '<up>', '<nop>', opts},
	    {'n', '<down>', '<nop>', opts},
	    {'n', '<left>', '<nop>', opts},
	    {'n', '<right>', '<nop>', opts},
	    {'i', '<up>', '<nop>', opts},
	    {'i', '<down>', '<nop>', opts},
	    {'i', '<left>', '<nop>', opts},
		{'i', '<right>', '<nop>', opts},
		{'v', '<up>', '<nop>', opts},
	    {'v', '<down>', '<nop>', opts},
		{'v', '<left>', '<nop>', opts},
		{'v', '<right>', '<nop>', opts},

		-- disable annoying job control
		{'n', 'c-z', 'nop', opts},
	}

	for _, val in pairs(mappings) do
		vim.keymap.set(unpack(val))
	end
end


--> set autocmds
local function set_autocmds()
	api.nvim_create_autocmd('InsertEnter', {
		-- enable cursorline when entering insert mode
		command = 'set cursorline',
	})

	api.nvim_create_autocmd('InsertLeave', {
		-- disable cursorline when leaving insert mode
		command = 'set nocursorline',
	})

	api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
		-- enable spellcheck on certain filetypes 
		pattern	= { '*.txt', '*.md', '*.tex' },
		command	= 'setlocal spell'
	})

	api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
		-- enable 'cindent' option on C files
		pattern = '*.c',
		command	= 'set cindent',
	})
end


set_globals()
set_options()
set_mappings()
set_autocmds()
