local common = require("insis.lsp.common-config")
local lspconfig = require("lspconfig")
local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  on_attach = function(_, bufnr)
    common.keyAttach(bufnr)
  end,
  cmd = { "nomicfoundation-solidity-language-server", "--stdio" },
  filetypes = { "solidity" },
  root_dir = lspconfig.util.find_git_ancestor,
  single_file_support = true,
}
return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
