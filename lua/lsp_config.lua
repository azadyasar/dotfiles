-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require'lspconfig'.gopls.setup{
	capabilities = capabilities,
	on_attach = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
		vim.keymap.set("n", "ff", vim.lsp.buf.formatting, {buffer=0})
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_next, {buffer=0})
		vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
		vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {buffer=0})
	end,
} -- connect to server



vim.opt.completeopt={"menu", "menuone", "noselect"}

-- Set up nvim-cmp.
local cmp = require'cmp'
local luasnip = require 'luasnip'

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			 -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			 luasnip.lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			-- elseif luasnip.expand_or_jumpable() then
			-- 	luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			-- elseif luasnip.jumpable(-1) then
			-- 	luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = 'buffer' },
	})
})


------------------------------------
-- Terraform
require'lspconfig'.terraformls.setup{
	on_attach = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_next, {buffer=0})
	end,
}
vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = vim.lsp.buf.formatting_sync,
})

-----------------------------------
--local nvim_lsp = require('lspconfig')

--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true

--local on_attach = function(client, bufnr)
--  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
--  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--  -- Mappings.
--  local opts = { noremap=true, silent=true }
--  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
--  buf_set_keymap('n', 'ga', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
--  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

--  -- Set some keybinds conditional on server capabilities
--  if client.resolved_capabilities.document_formatting then
--    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
--  elseif client.resolved_capabilities.document_range_formatting then
--    buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
--  end

--  -- Set autocommands conditional on server_capabilities
--  if client.resolved_capabilities.document_highlight then
--    vim.api.nvim_exec([[
--      hi LspReferenceRead cterm=bold ctermbg=DarkMagenta guibg=LightYellow
--      hi LspReferenceText cterm=bold ctermbg=DarkMagenta guibg=LightYellow
--      hi LspReferenceWrite cterm=bold ctermbg=DarkMagenta guibg=LightYellow
--      augroup lsp_document_highlight
--        autocmd! * <buffer>
--        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
--        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
--      augroup END
--    ]], false)
--  end
--end

--nvim_lsp.gopls.setup{
--	cmd = {'gopls', 'serve'},
--	-- for postfix snippets and analyzers
--	capabilities = capabilities,
--	    settings = {
--	      gopls = {
--		      experimentalPostfixCompletions = true,
--		      analyses = {
--		        unusedparams = true,
--		        shadow = true,
--		     },
--		     staticcheck = true,
--				 linksInHover = false,
--				 codelenses = {
--						generate = true,
--						gc_details = true,
--						regenerate_cgo = true,
--						tidy = true,
--						upgrade_depdendency = true,
--						vendor = true,
--				 },
--				 usePlaceholders = true,
--		    },
--	    },
--	on_attach = on_attach,
--}

 function goimports(timeoutms)
   local context = { source = { organizeImports = true } }
   vim.validate { context = { context, "t", true } }

   local params = vim.lsp.util.make_range_params()
   params.context = context

   -- See the implementation of the textDocument/codeAction callback
   -- (lua/vim/lsp/handler.lua) for how to do this properly.
   local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
   if not result or next(result) == nil then return end
   local actions = result[1].result
   if not actions then return end
   local action = actions[1]

   -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
   -- is a CodeAction, it can have either an edit, a command or both. Edits
   -- should be executed first.
   if action.edit or type(action.command) == "table" then
     if action.edit then
       vim.lsp.util.apply_workspace_edit(action.edit, 'utf-16')
     end
     if type(action.command) == "table" then
       vim.lsp.buf.execute_command(action.command)
     end
   else
     vim.lsp.buf.execute_command(action)
   end
 end

----vim.lsp.set_log_level("debug")

