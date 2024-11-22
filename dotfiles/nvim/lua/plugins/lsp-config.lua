return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bicep",
          "bashls",
          "azure_pipelines_ls",
          "jsonls",
          "pylsp",
          "terraformls",
          "yamlls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      -- configure lua
      lspconfig.lua_ls.setup({})
      -- configure Bicep
      lspconfig.bicep.setup({
		cmd = { "dotnet", "/usr/local/bin/bicep-langserver/Bicep.LangServer.dll" }
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.bicep",
        callback = function()
          vim.lsp.buf.format({ async = true })
        end,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
