local config = require("java-deps.config")

local M = {
  items = {
    nsid = vim.api.nvim_create_namespace("java-deps-items"),
  },
}

M.init_hl = function()
  local highlights = config.options.highlights or {}
  for name, hl in pairs(highlights) do
    vim.api.nvim_set_hl(0, "JavaDeps" .. name, hl)
  end
end
M.clear_all_ns = function(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, M.items.nsid, 0, -1)
end

---@param bufnr number
---@param hl_info table
---@param _ TreeItem[]
function M.add_item_highlights(bufnr, hl_info, _)
  for _, line_hl in ipairs(hl_info) do
    local line, hl_start, hl_end, hl_type = unpack(line_hl)
    vim.api.nvim_buf_set_extmark(bufnr, M.items.nsid, line - 1, hl_start, {
      end_col = hl_end,
      hl_group = hl_type,
    })
  end
end

return M
