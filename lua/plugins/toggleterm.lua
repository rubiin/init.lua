
return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    cmd = "ToggleTerm",
    keys = {
      {
        "<leader>tf",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 0, Util.root.get(), "float")
        end,
        desc = "ToggleTerm (float root_dir)",
      },
      {
        "<leader>th",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, 15, Util.root.get(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal root_dir)",
      },
      {
        "<leader>tv",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, vim.o.columns * 0.4, Util.root.get(), "vertical")
        end,
        desc = "ToggleTerm (vertical root_dir)",
      },
    },
    opts = {
      -- size can be a number or function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<c-\>]],
      -- on_open = fun(t: Terminal), -- function to run when the terminal opens
      -- on_close = fun(t: Terminal), -- function to run when the terminal closes
      -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
      -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
      -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
      hide_numbers = true, -- hide the number column in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      -- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      direction = "horizontal" or "vertical" or "window" or "float",
      -- direction = "vertical",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = vim.o.shell, -- change the default shell
      -- This field is only relevant if direction is set to 'float'
      float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved', -- single/double/shadow/curved
        width = math.floor(0.7 * vim.fn.winwidth(0)),
        height = math.floor(0.8 * vim.fn.winheight(0)),
        winblend = 4,
      },
      on_open = function(term)
        require('shade').toggle();
      end,
      ---@diagnostic disable-next-line: unused-local
      on_close = function(term)
        require('shade').toggle();
      end,
    },
  },
}
