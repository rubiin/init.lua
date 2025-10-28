-- Define the sign
vim.fn.sign_define("LightBulbSign", { text = "💡", texthl = "DiagnosticSignInfo" })

local function safe_update_lightbulb()
  local bufnr = vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  if #clients == 0 then
    vim.fn.sign_unplace("lightbulb", { buffer = bufnr })
    return
  end

  local client = clients[1]
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local params = {
    textDocument = { uri = vim.uri_from_bufnr(bufnr) },
    range = {
      start = { line = row - 1, character = col },
      ["end"] = { line = row - 1, character = col },
    },
    context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, row) },
  }

  vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, actions)
    if err or not actions or vim.tbl_isempty(actions) then
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.fn.sign_unplace("lightbulb", { buffer = bufnr })
      end
    else
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.fn.sign_place(1, "lightbulb", "LightBulbSign", bufnr, { lnum = vim.fn.line("."), priority = 10 })
      end
    end
  end)
end

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { callback = safe_update_lightbulb })
