
-- adds header to new file if it is a shell script

vim.cmd([[
autocmd BufNewFile *.sh lua SetTitle()
]])

function SetTitle()
    if vim.fn.expand("%:e") == "sh" then
        vim.fn.setline(1, "#!/bin/bash")
        vim.fn.setline(2, "#")
        vim.fn.setline(3, "#**************************************************")
        vim.fn.setline(4, "# Author:         rubiin                          *")
        vim.fn.setline(5, "# E-mail:         roobin.bhandari@gmail.com       *")
        vim.fn.setline(6, "# Date:           " .. os.date("%Y-%m-%d") .. "                      *")
        vim.fn.setline(7, "# Description:                              *")
        vim.fn.setline(8, "# Copyright " .. os.date("%Y") .. " by rubiin.All Rights Reserved  *")
        vim.fn.setline(9, "#**************************************************")
        vim.fn.setline(10, "")
        vim.fn.setline(11, "")
    end
end

vim.cmd([[
autocmd BufNewFile * normal G
]])
