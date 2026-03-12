vim.g.mapleader = " "

------------------------------------------------
-- basic settings
------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

------------------------------------------------
-- lazy bootstrap
------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git","clone","--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)

------------------------------------------------
-- plugins
------------------------------------------------
require("lazy").setup({

  ------------------------------
  -- colorscheme
  ------------------------------
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end
  },

  ------------------------------
  -- statusline
  ------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({})
    end
  },

  ------------------------------
  -- telescope
  ------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  ------------------------------
  -- git
  ------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },

  ------------------------------
  -- LSP
  ------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach = function(client, bufnr)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- shared config applied to all servers
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })

      -- lua-specific overrides
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
          }
        }
      })

      vim.lsp.enable({ "pyright", "ts_ls", "lua_ls" })
    end
  },

  ------------------------------
  -- completion
  ------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },

    config = function()

      local cmp = require("cmp")

      cmp.setup({

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({

          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),

          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),

        }),

        sources = {
          { name = "nvim_lsp" }
        }

      })

    end
  },

})

------------------------------------------------
-- keymaps
------------------------------------------------

local telescope = require("telescope.builtin")

vim.keymap.set("n","<leader>ff",telescope.find_files)
vim.keymap.set("n","<leader>fg",telescope.live_grep)
vim.keymap.set("n","<leader>fb",telescope.buffers)
vim.keymap.set("n","<leader>fh",telescope.help_tags)

vim.keymap.set("n","<leader>w",":w<CR>")
vim.keymap.set("n","<leader>q",":q<CR>")

vim.keymap.set("n","<C-h>","<C-w>h")
vim.keymap.set("n","<C-l>","<C-w>l")
vim.keymap.set("n","<C-j>","<C-w>j")
vim.keymap.set("n","<C-k>","<C-w>k")
