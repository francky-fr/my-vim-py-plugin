-- In init.lua
vim.cmd([[
py3 << EOF
import dadbod
def vim_get_connection_str(region, host, workgroup, port, db):
    return dadbod.get_iam_connection_str(region, host, workgroup, port, db)
EOF
]])

-- Define your database configurations
local db_configs = {
    DB1 = { region = "eu-central-1", host = "wilson-dev.891239948857.eu-central-1.redshift-serverless.amazonaws.com", workgroup = "wilson-dev", port = 5439, db = "dev" },
    -- DB1 = { region = "us-west-1", host = "example-host1.com", workgroup = "workgroup1", port = 5432, db = "database1" },
    DB2 = { region = "us-west-2", host = "example-host2.com", workgroup = "workgroup2", port = 5432, db = "database2" },
    -- Add more databases as needed
}

-- Function to connect to a database and open Dadbod
local function connect_to_db(db_key)
    local config = db_configs[db_key]
    if not config then
        print("Error: Database shortcut '" .. db_key .. "' not found!")
        return
    end

    -- Call the predefined Python function to get the connection string
    local connection_str = vim.fn.py3eval(
        string.format(
            "vim_get_connection_str('%s', '%s', '%s', %d, '%s')",
            config.region, config.host, config.workgroup, config.port, config.db
        )
    )

    vim.g.db = connection_str

    -- Open Dadbod interface
    vim.cmd("DB " .. connection_str)
end

-- Create commands for each database shortcut
for db_key, _ in pairs(db_configs) do
    vim.api.nvim_create_user_command(db_key, function()
        connect_to_db(db_key)
    end, {})
end
