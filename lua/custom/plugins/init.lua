-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-rhubarb' },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },
  { 'Mr-LLLLL/interestingwords.nvim', opts = {
    color_key = '<leader>i',
    cancel_color_key = '<leader>I',
  }, event = 'VeryLazy' },
  -- copied from
  -- https://github.com/rafi/vim-config/blob/7d145d1e2960991f3a2109e1718cfee0b55a9010/lua/rafi/plugins/git.lua#L172
  {
    'rhysd/git-messenger.vim',
    cmd = 'GitMessenger',
    keys = {
      { '<Leader>gm', '<Plug>(git-messenger)', desc = 'Git messenger' },
    },
    init = function()
      vim.g.git_messenger_include_diff = 'current'
      vim.g.git_messenger_no_default_mappings = false
      vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
    end,
    event = 'VeryLazy',
  },
  -- copy from
  -- https://github.com/escwxyz/nvim/blob/8d516e32f9c2bbd77e13e762e3a5a4077293fce5/lua/plugins/editor.lua#L286
  {
    'AckslD/nvim-neoclip.lua',
    dependencies = {
      'kkharji/sqlite.lua',
    },
    cmd = 'Telescope neoclip',
    keys = {
      { '<leader>y', '<cmd>Telescope neoclip<CR>', desc = 'Neoclip (Yank History)' },
    },
    config = function()
      require('neoclip').setup {}
      require('telescope').load_extension 'neoclip'
    end,
  },
  -- copy from
  -- https://yasushisakai.com/neovim.html#orgc58e546
  {
    'numToStr/FTerm.nvim',
    opts = {--[[ things you want to change go here]]
    },
    config = function()
      function is_terminal_open()
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if vim.bo[bufnr].buftype == 'terminal' then
            return true
          end
        end
        return false
      end

      -- UserCommands
      vim.api.nvim_create_user_command('OpenLazyGit', function()
        require('FTerm').scratch { cmd = 'lazygit', config = { auto_close = true } }
      end, { bang = true })

      vim.api.nvim_create_user_command('ToggleOneShotTerminal', function()
        local fterm = require 'FTerm'
        if is_terminal_open() then
          fterm.exit()
        else
          fterm.open()
        end
      end, { bang = true })

      require('FTerm').setup {}
      -- local wk = require('which-key')
      -- wk.register({
      -- 	t = {'<cmd>lua require("FTerm").toggle()<cr>', "Open Terminal"},
      -- 	a = {'<cmd>ToggleOneShotTerminal<cr>', "Toggle Terminal"},
      -- 	v = {'<cmd>OpenLazyGit<cr>', "Version Control (git)"},
      -- }, {prefix="<leader>"})
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }
      map('n', '<A-f>', '<cmd>lua require("FTerm").toggle()<cr>', opts)
      map('t', '<A-f>', [[<C-\><C-n><CMD>lua require("FTerm").toggle()<cr>]], opts)
    end,
  },
  -- copy from
  -- https://yasushisakai.com/neovim.html#orgc58e546
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').load_extension 'file_browser'
    end,
  },

  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    config = function()
      local map = vim.api.nvim_set_keymap

      -- config 为空时，默认执行的操作时 require("plugin").setup()
      -- 这里我们重载了 config，就要显示的调用 require("plugin").setup()
      require('barbar').setup {

        noremap = true,
        silent = true,
        highlight_inactive_file_icons = false,
        highlight_visible = false,
      }
      local opts = { noremap = true, silent = true }
      -- Move to previous/next
      map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
      map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
      -- Re-order to previous/next
      map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
      map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
      -- Goto buffer in position...
      map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
      map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
      map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
      map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
      map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
      -- Close buffer
      map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
    end,

    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  {
    'phaazon/hop.nvim',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require('hop').setup { keys = 'fjrudkeiwosl' }
      vim.keymap.set('n', '<M-h>', function()
        vim.cmd [[:HopChar1]]
      end, { silent = true })
    end,
    event = 'VeryLazy',
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'Iron-E/nvim-tabmode',
    cmd = 'TabmodeEnter', -- don't load until using this command
    config = true, -- automatically call `bufmode.setup()`; not needed if you specify `opts`
    dependencies = { 'Iron-E/nvim-libmodal' },
    keys = { { '<Leader><Tab>', desc = 'Enter buffer mode', mode = 'n' } }, -- don't load until pressing these keys
    -- opts = {}, (put `setup` options here, e.g. `opts = {enter_mapping = false}`
    event = 'VeryLazy',
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup {
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
      }
    end,
    keys = {
      { '<leader>a', '<cmd>AerialToggle float<cr>', desc = 'Aerial (Symbols)' },
      { '<leader>sa', '<cmd>Telescope aerial<cr>', desc = 'Telecope Aerial (Symbols)' },
      { '<M-a>', '<cmd>AerialToggle<cr>', desc = 'Telecope Aerial (Symbols)' },
    },
    event = 'VeryLazy',
  },
  {
    'fraso-dev/nvim-listchars',
    config = function()
      vim.opt.list = true
      require('nvim-listchars').setup {
        save_state = false,
        listchars = {
          trail = '-',
          eol = '↲',
          tab = '» ',
        },
        exclude_filetypes = {
          'markdown',
        },
        lighten_step = 10,
      }
    end,
  },
}
