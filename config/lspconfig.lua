local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      local luarc_stat = vim.uv.fs_stat(path .. '/.luarc.json')
      local luarc_statc = vim.uv.fs_stat(path .. '/.luarc.jsonc')
      if path ~= vim.fn.stdpath 'config' and (luarc_stat or luarc_statc) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT',
        -- Tell the language server how to find Lua modules same way as Neovim
        -- (see `:h lua-module-load`)
        path = {
          'lua/?.lua',
          'lua/?/init.lua',
        },
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths
          -- here.
          -- '${3rd}/luv/library'
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    })
  end,
  settings = {
    capabilities = capabilities,
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
})

vim.lsp.enable 'lua_ls'
vim.lsp.enable 'nixd'
vim.lsp.enable 'bashls'
