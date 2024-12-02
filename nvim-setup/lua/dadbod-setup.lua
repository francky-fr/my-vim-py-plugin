vim.cmd([[
py3 << EOF
import dadbod
def vim_get_connection_str(region, host, workgroup, port, db):
    return dadbod.get_iam_connection_str(region, host, workgroup, port, db)
EOF
]])

local function wilson_dev_url()
    return vim.fn.py3eval(string.format(
        [[vim_get_connection_str('%s', '%s', '%s', %d, '%s')]],
        "eu-central-1",
        "wilson-dev.891239948857.eu-central-1.redshift-serverless.amazonaws.com",
        "wilson-dev",
        5439,
        "dev"
    ))
end

vim.g.dbs = {
    {
        name = 'DB1',
        url = function()
            return wilson_dev_url()  -- Dynamically resolve the URL for this database
        end
    }
}

