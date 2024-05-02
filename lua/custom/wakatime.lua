local uv = vim.loop
local M = {}

M.get_wakatime_time = function()
  local async = require("plenary.async")
  local Job = require("plenary.job")

  local tx, rx = async.control.channel.oneshot()
  local ok, job = pcall(Job.new, Job, {
    command = os.getenv("HOME") .. "/.wakatime/wakatime-cli",
    args = { "--today" },
    on_exit = function(j, _)
      tx(vim.split(j:result()[1], ",")[1] or "")
    end,
  })
  if not ok then
    print("Bad WakaTime call: " .. job)
    return ""
  end

  -- if data then return "🅆  " .. data:sub(1, #data - 2) .. " " end
  job:start()
  return rx()
end

---@diagnostic disable
local state = { comp_wakatime_time = "" }

M.wakatime = function()
  local WAKATIME_UPDATE_INTERVAL = 10000

  if not Wakatime_routine_init then
    local timer = uv.new_timer()
    if timer == nil then
      return ""
    end
    -- Update wakatime every 60 second
    uv.timer_start(timer, 60000, WAKATIME_UPDATE_INTERVAL, function()
      require("plenary.async").run(M.get_wakatime_time, function(time)
        state.comp_wakatime_time = time
      end)
    end)
    Wakatime_routine_init = true
  end

  return state.comp_wakatime_time
end
return M
