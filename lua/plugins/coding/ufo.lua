-- ufo code folding

local user_icons = require("custom.icons")

return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "LazyFile",
    lazy = true,
    opts = {
      -- Use treesitter as a main provider
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
      fold_virt_text_handler = function(virtual_text, left_number, end_line_number, width, truncate)
        local new_virtual_text = {}
        local fn = vim.fn
        local suffix = (" %s %d "):format(user_icons.ui.Ellipsis, end_line_number - left_number)
        local suffix_width = fn.strdisplaywidth(suffix)
        local target_width = width - suffix_width
        local current_width = 0
        for _, chunk in ipairs(virtual_text) do
          local chunk_text = chunk[1]
          local chunk_width = fn.strdisplaywidth(chunk_text)
          if target_width > current_width + chunk_width then
            table.insert(new_virtual_text, chunk)
          else
            chunk_text = truncate(chunk_text, target_width - current_width)
            local hl_group = chunk[2]
            table.insert(new_virtual_text, { chunk_text, hl_group })
            chunk_width = fn.strdisplaywidth(chunk_text)

            -- str width returned from truncate() may less than 2nd argument, need padding

            if current_width + chunk_width < target_width then
              suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
            end
            break
          end
          current_width = current_width + chunk_width
        end
        table.insert(new_virtual_text, { suffix, "MoreMsg" })
        return new_virtual_text
      end,
    },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open All Folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close All Folds",
      },
      {
        "zp",
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek Fold",
      },
    },
  },
}
