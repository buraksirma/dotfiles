require'buffline'         .setup {}
require'statusline'
require'dashboard'        .setup {}
require'gitsigns'         .setup {}
require'lspsaga'          .setup {}
require'nvim-autopairs'   .setup {}
require'nvim-tree'        .setup { auto_close = true }
require'trouble'          .setup {}
require'indent_blankline' .setup {
    show_current_context = true,
    show_current_context_start = false,
    filetype_exclude = {
        "lspinfo", "packer", "checkhealth", "help", "", "alpha"
    }
}
require'telescope'.setup {
    pickers = {
        find_files = {
            hidden = true
        },
    },
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden"
        },
    }
}

-- LSP settings
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua require "telescope.builtin".lsp_type_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua require "telescope.builtin".lsp_definitions()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua require "telescope.builtin".lsp_implementations()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua require "telescope.builtin".lsp_references()<CR>', opts)

    -- LSP SAGA HOTKEYS
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- CMP
local cmp     = require'cmp'
local lspkind = require'lspkind'

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
    window = {
        completion = {
            border = 'rounded',
            scrollbar = '║',
        },
        documentation = {
            border = 'rounded',
            scrollbar = '║',
        },
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                nvim_lua = "[Lua]",
                latex_symbols = "[Latex]",
                ultisnips = "[UltiSnips]",
            })
        }),
    },
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.fn["UltiSnips#JumpForwards"]()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                vim.fn["UltiSnips#JumpBackwards"]()
            else
                fallback()
            end
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
    },
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities       = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local nvim_lsp = require 'lspconfig'
local servers  = { 'tsserver' }

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }
end


-- TREE Sitter - Language servers
require'nvim-treesitter.configs'.setup {
    autotag = {
        enable = true,
    },
    highlight = {
        enable = true,
        disable = {},
    },
    indent = {
        enable = false,
        disable = {},
    },
    ensure_installed = {
        "tsx",
        "toml",
        "fish",
        "json",
        "yaml",
        "html",
        "scss"
    },
}
-- Diagnostics
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua require'lspsaga.diagnostic'.show_cursor_diagnostics()]]

vim.diagnostic.config { 
    virtual_text = { prefix = '●' },
    update_in_insert = false,
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
