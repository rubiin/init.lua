-- adds header to new file if it is a shell script

local fn = vim.fn

vim.cmd([[
autocmd BufNewFile *.sh lua SetTitle()
]])

function SetTitle()
  if fn.expand('%:e') == 'sh' then
    fn.setline(1, '#!/bin/bash')
    fn.setline(2, '#')
    fn.setline(3, '#**************************************************')
    fn.setline(4, '# Author:         rubiin                          *')
    fn.setline(5, '# E-mail:         roobin.bhandari@gmail.com       *')
    fn.setline(6, '# Date:           ' .. os.date('%Y-%m-%d') .. '                      *')
    fn.setline(7, '# Description:                              *')
    fn.setline(8, '# Copyright ' .. os.date('%Y') .. ' by rubiin.All Rights Reserved  *')
    fn.setline(9, '#**************************************************')
    fn.setline(10, '')
    fn.setline(11, '')
  end
end

vim.cmd([[
autocmd BufNewFile * normal G
]])
