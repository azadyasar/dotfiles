local ok, ts = pcall(require, 'nvim-treesitter.configs')
if not ok then return end

ts.setup({
  ensure_installed = {
    'lua', 'vim', 'vimdoc', 'dart', 'java', 'kotlin', 'go',
    'python', 'typescript', 'tsx', 'javascript', 'json', 'yaml',
    'bash', 'markdown', 'markdown_inline', 'html', 'css',
    'hcl', 'terraform', 'sql', 'dockerfile', 'toml',
  },
  highlight = { enable = true, additional_vim_regex_highlighting = false },
  indent = { enable = true },
})
