---@type vim.lsp.Config
return {
  cmd = { 'rust-analyzer'}, -- ,  '--stdio' },
  filetypes = { 'rust','.rs' },
  root_markers = {
    'Cargo.toml',
    '.git',
  },
}
