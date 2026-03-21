---@type vim.lsp.Config
return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc" },
    settings = {
        Lua = {
            runtime = {
                -- Neovim использует LuaJIT (Lua 5.1)
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" }, -- не ругаемся на vim
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
