-- Handle jdt:// URIs so "go to definition" works for classes inside JARs.
-- When Neovim's built-in LSP handler tries to open a jdt:// buffer,
-- BufReadCmd fires and we fetch the decompiled source from jdtls.
vim.api.nvim_create_autocmd('BufReadCmd', {
  pattern = 'jdt://*',
  callback = function(ev)
    local uri = vim.uri_from_bufnr(ev.buf)
    local clients = vim.lsp.get_clients({ name = 'jdtls' })
    if #clients == 0 then
      return
    end

    local content = clients[1]:request_sync('java/classFileContents', { uri = uri }, 5000, 0)
    if content and content.result then
      local lines = vim.split(content.result, '\n', { trimempty = true })
      vim.bo[ev.buf].modifiable = true
      vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, lines)
      vim.bo[ev.buf].modifiable = false
      vim.bo[ev.buf].filetype = 'java'
      vim.bo[ev.buf].buftype = 'nofile'
    end
  end,
})

return {
  cmd = { 'jdtls' },
  filetypes = { 'java' },
  root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
  init_options = {
    extendedClientCapabilities = {
      classFileContentsSupport = true,
      resolveAdditionalTextEditsSupport = true,
    },
  },
  settings = {
    java = {
      contentProvider = { preferred = 'fernflower' },
      eclipse = { downloadSources = true },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      maven = {
        downloadSources = true,
      },
      referencesCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },
    },
  },
}
