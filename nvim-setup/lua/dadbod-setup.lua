vim.cmd([[
py3 << EOF
import dadbod
def vim_get_connection_str(region, host, workgroup, port, db):
    return dadbod.get_iam_connection_str(region, host, workgroup, port, db)
def vim_get_connection_str_from_sm(region, sm_path):
    return dadbod.get_iam_connection_str_from_sm(region, sm_path)
EOF
]])

local function wilson_red_dev_url()
    ret = vim.fn.py3eval(string.format(
        [[vim_get_connection_str('%s', '%s', '%s', %d, '%s')]],
        "eu-central-1",
        "wilson-dev.891239948857.eu-central-1.redshift-serverless.amazonaws.com",
        "wilson-dev",
        5439,
        "dev"
    ))
    return ret
end

local function wilson_pg_dev_url()
    ret = vim.fn.py3eval(string.format(
        [[vim_get_connection_str_from_sm('%s', '%s')]],
        "eu-central-1",
        "/dev/wilson/DATABASES_RO"
    ))
    return ret
end

vim.g.dbs = {
    {
        name = '(DB1)Wilson-Red',
        url = function()
            return wilson_red_dev_url()
        end
    },
    {
        name = '(Dev)Wilson-PG',
        url = function()
            return wilson_pg_dev_url()
        end
    }
}
vim.g.db_ui_execute_on_save = 0
vim.g.db_ui_save_location = "~/queries/"

-- Function to map <C-s> to save the query
function _G.map_ctrl_s_for_save_query()
  if vim.bo.filetype == "sql" then
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-s>', '<Plug>(DBUI_SaveQuery)', { noremap = true, silent = true })
  end
end

-- Autocommand to apply the mapping only in SQL buffers
vim.api.nvim_exec([[
  augroup DBUIMapCtrlS
    autocmd!
    autocmd FileType sql lua map_ctrl_s_for_save_query()
  augroup END
]], false)


vim.keymap.set("n", "<C-r>", ":Lazy reload vim-dadbod-ui<CR>", { noremap = true, silent = true, desc = "Reload vim-dadbod-ui" })

-- For query Execution
vim.keymap.set('n', '<C-e>', ":%DB<CR>", { noremap = true, silent = true })
vim.keymap.set('x', '<C-e>', 'db#op_exec()', { expr = true })
vim.keymap.set('n', 'ee', ":.DB<CR>", { noremap = true, silent = true })

-- Redshift Compat
vim.g.db_ui_use_postgres_views = 0
