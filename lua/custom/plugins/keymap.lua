
local rhs_options = {}

function rhs_options:new()
	local instance = {
		cmd = "",
		options = {
			noremap = false,
			silent = false,
			expr = false,
			nowait = false
		}
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

function rhs_options:map_cmd(cmd_string)
	self.cmd = cmd_string
	return self
end

function rhs_options:map_cr(cmd_string)
	self.cmd = (":%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:map_args(cmd_string)
	self.cmd = (":%s<Space>"):format(cmd_string)
	return self
end

function rhs_options:map_cu(cmd_string)
	self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:with_silent()
	self.options.silent = true
	return self
end

function rhs_options:with_noremap()
	self.options.noremap = true
	return self
end

function rhs_options:with_expr()
	self.options.expr = true
	return self
end

function rhs_options:with_nowait()
	self.options.nowait = true
	return self
end

local bind = {}

function bind.map_cr(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cr(cmd_string)
end

function bind.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function bind.map_cu(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cu(cmd_string)
end

function bind.map_args(cmd_string)
	local ro = rhs_options:new()
	return ro:map_args(cmd_string)
end

function bind.nvim_load_mapping(mapping)
	for key, value in pairs(mapping) do
		local mode, keymap = key:match("([^|]*)|?(.*)")
		if type(value) == "table" then
			local rhs = value.cmd
			local options = value.options
			vim.api.nvim_set_keymap(mode, keymap, rhs, options)
		end
	end
end

local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd

-- default map
local def_map = {
	-- Vim map
	["n|<A-d>"] = map_cr("bdelete!"):with_noremap():with_silent(),
	["n|<A-B>"] = map_cr("bwipe"):with_noremap():with_silent(),
	["n|<A-w>"] = map_cr("write"):with_noremap():with_silent(),

	-- when searching， zz makes cursor line in the middle
	["n|n"] = map_cmd("nzzzv"):with_noremap(),
	["n|N"] = map_cmd("Nzzzv"):with_noremap(),

	-- window
	["n|<leader><leader>s"] = map_cr("split"):with_silent(),
	["n|<leader><leader>v"] = map_cr("vsplit"):with_silent(),
	["n|<TAB>"] = map_cmd("<c-w>w"):with_silent():with_noremap(),

	-- Visual
	["v|J"] = map_cmd(":m '>+1<cr>gv=gv"),
	["v|K"] = map_cmd(":m '<-2<cr>gv=gv"),

	["n|<M-q>"] = map_cr("q"),
	["n|<M-Q>"] = map_cr("qall!"),
	["i|jk"] = map_cmd("<c-c>"),
	["n|<M-j>"] = map_cmd("jzz"):with_noremap(),
	["n|<M-k>"] = map_cmd("kzz"):with_noremap(),
	["n|<M-Up>"] = map_cr(":resize +2"):with_noremap():with_nowait():with_silent(),
	["n|<M-Down>"] = map_cr(":resize -2"):with_noremap():with_nowait():with_silent(),
	["n|<M-Left>"] = map_cr(":vertical resize +2"):with_noremap():with_nowait():with_silent(),
	["n|<M-Right>"] = map_cr(":vertical resize -2"):with_noremap():with_nowait():with_silent(),

	["n|<F5>"] = map_cr(":!./rsync.sh"),

	-- vim-fugitive
	["n|<M-g>"] = map_cr("G"),
}


local plug_map = {

	-- ["n|<Leader>fs"] = map_cu("Telescope lsp_dynamic_workspace_symbols"):with_noremap():with_silent(),
	-- ["n|<Leader>fc"] = map_cu("Telescope current_buffer_fuzzy_find"):with_noremap():with_silent(),
	-- ["n|<Leader>fC"] = map_cu("Telescope neoclip"):with_noremap():with_silent(),
	-- ["n|gd"] = map_cu("Telescope lsp_definitions"):with_noremap():with_silent(),
	-- ["n|gr"] = map_cu("Telescope lsp_references"):with_noremap():with_silent(),

	-- Plugin Telescope

}

bind.nvim_load_mapping(def_map)

bind.nvim_load_mapping(plug_map)

return {}
