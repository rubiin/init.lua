local M = {}

-- use this for more https://patorjk.com/software/taag/#p=display&f=ANSI%20Shadow or https://textfancy.com/text-art/
-- you may need to adjust the padding on the headers to fit your screen mostly the vertical padding as done on the first header
local headers = {
  [[
    ███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
    ████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
    ██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
    ██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
    ██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
    ╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
    ]],

  [[
                                     ██
                                    ░░
  ███████   █████   ██████  ██    ██ ██ ██████████
 ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
  ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
  ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
  ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
 ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
    ]],

  [[
    ┏━━━┓┏━━━┓┏━━━┓┏┓━┏┓━━━━━━┏━━┓━┏━━━━┓┏┓┏┓┏┓
    ┃┏━┓┃┃┏━┓┃┃┏━┓┃┃┃━┃┃━━━━━━┃┏┓┃━┃┏┓┏┓┃┃┃┃┃┃┃
    ┃┃━┃┃┃┗━┛┃┃┃━┗┛┃┗━┛┃━━━━━━┃┗┛┗┓┗┛┃┃┗┛┃┃┃┃┃┃
    ┃┗━┛┃┃┏┓┏┛┃┃━┏┓┃┏━┓┃━━━━━━┃┏━┓┃━━┃┃━━┃┗┛┗┛┃
    ┃┏━┓┃┃┃┃┗┓┃┗━┛┃┃┃━┃┃━━━━━━┃┗━┛┃━┏┛┗┓━┗┓┏┓┏┛
    ┗┛━┗┛┗┛┗━┛┗━━━┛┗┛━┗┛━━━━━━┗━━━┛━┗━━┛━━┗┛┗┛━
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  ]],
  [[
================================================.
     .-.   .-.     .--.                         |
    | OO| | OO|   / _.-' .-.   .-.  .-.   .''.  |
    |   | |   |   \  '-. '-'   '-'  '-'   '..'  |
    '^^^' '^^^'    '--'                         |
===============.  .-.  .================.  .-.  |
               | |   | |                |  '-'  |
               | |   | |                |       |
               | ':-:' |                |  .-.  |
               |  '-'  |                |  '-'  |
==============='       '================'       |
    ]],
  [[
                                                                        ,
          ████ ██████           █████      ██                     ,
         ███████████             █████                             ,
         █████████ ███████████████████ ███   ███████████   ,
        █████████  ███    █████████████ █████ ██████████████   ,
       █████████ ██████████ █████████ █████ █████ ████ █████   ,
     ███████████ ███    ███ █████████ █████ █████ ████ █████  ,
    ██████  █████████████████████ ████ █████ █████ ████ ██████ ,

]],
  [[
           ____                                         ,
          /___/\_                                       ,
         _\   \/_/\__                                   ,
       __\       \/_/\            .--.--.|__|.--.--.--. ,
       \   __    __ \ \           |  |  ||  ||        | ,
      __\  \_\   \_\ \ \   __      \___/ |__||__|__|__| ,
     /_/\\   __   __  \ \_/_/\                          ,
     \_\/_\__\/\__\/\__\/_\_\/                          ,
        \_\/_/\       /_\_\/                            ,
           \_\/       \_\/                              ,
]],
  [[
     ★　✯   🛸                    🪐   .°•    |    ,
        __     ° ★　•       🛰       __      / \   ,
       / /   ____ ___  ______  _____/ /_    | O |  ,
      / /   / __ `/ / / / __ \/ ___/ __ \   | O |  ,
     / /___/ /_/ / /_/ / / / / /__/ / / /  /| | |\ ,
    /_____/\__,_/\__,_/_/ /_/\___/_/ /_/  /_(.|.)_\,
]],

  [[🛸　　　 　🌎　°　　🌓　•　　.°•　　　🚀 ✯
    　　　★　*　　　　　°　　　　🛰 　°·      🪐
    .　　　•　° ★　•  ☄

      ▁▂▃▄▅▆▇▇▆▅▄▃▂▁

                                                  ]],
}

function M.dashboard()
  math.randomseed(os.time())
  local logo = headers[math.random(#headers)]

  -- add padding to the top and bottom of the logo
  logo = string.rep("\n", 2) .. logo .. "\n"
  logo = logo .. "  " .. "[ @"..(vim.g.github_username or "rubiin").." ]" .. "\n\n"

  return logo
end

return M
