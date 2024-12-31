vim.cmd([[
py3 << EOF
import dadbod
def vim_get_connection_str(region, host, workgroup, port, db):
    return dadbod.get_iam_connection_str(region, host, workgroup, port, db)
EOF
]])

local function wilson_dev_url()
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

vim.g.dbs = {
    {
        name = 'DB1',
        url = function()
            return wilson_dev_url()
        end
    }
}
vim.g.db_ui_execute_on_save = 0


vim.g.db_ui_save_location = "~/queries/"

local opts = { noremap = true, silent = true }

-- Function to remap <C-s> to <Plug>(DBUI_SaveQuery) in the script window
function _G.map_ctrl_s_for_save_query()
  if vim.bo.filetype == "sql" then
    vim.api.nvim_buf_set_keymap(0, 'n', '<C-s>', '<Plug>(DBUI_SaveQuery)', opts)
  end
end

-- Autocommand to apply the mapping only in script buffers
vim.api.nvim_exec([[
  augroup DBUIMapCtrlS
    autocmd!
    autocmd FileType sql lua map_ctrl_s_for_save_query()
  augroup END
]], false)

vim.keymap.set("n", "<C-r>", ":Lazy reload vim-dadbod-ui<CR>", { noremap = true, silent = true, desc = "Reload vim-dadbod-ui" })
