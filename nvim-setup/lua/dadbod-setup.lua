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

vim.g.db_ui_save_location = "~/queries/"

local opts = { noremap = true, silent = true }

function new_saved_query()
  local db_name = vim.fn['db#ui#get_selected_connection']() or "default"
  local datetime = os.date("%Y-%m-%d_%H-%M-%S")
  local file_path = string.format("%s/%s/%s.sql", vim.g.db_ui_save_location, db_name, datetime)
  vim.cmd("e " .. file_path)
end
vim.api.nvim_set_keymap('n', '<leader>n', ':lua new_saved_query()<CR>', opts)

vim.keymap.set("n", "<C-r>", ":Lazy reload vim-dadbod-ui<CR>", { noremap = true, silent = true, desc = "Reload vim-dadbod-ui" })


