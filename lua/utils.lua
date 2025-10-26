local M = { timer = {} }

local function week_passed(marker_path)
  local stat = vim.loop.fs_stat(marker_path)
  if not stat then
    return true
  end

  local now = os.time()
  local week = 7 * 24 * 60 * 60

  local modified_time = stat.mtime.sec + stat.mtime.nsec / 1e9

  return now - modified_time >= week
end

local function create_marker(marker_path)
  local dir = vim.fn.fnamemodify(marker_path, ':h')

  if dir ~= '' and not vim.loop.fs_stat(dir) then
    vim.loop.fs_mkdir(dir, -1)
  end

  if vim.fn.filereadable(marker_path) == 1 then
    vim.fn.delete(marker_path)
  end

  local fd = vim.loop.fs_open(marker_path, 'w', 420)
  if fd then
    vim.loop.fs_write(fd, '1', nil)
    vim.loop.fs_close(fd)
  end
end

function M.timer.background_checker()
  local marker_path = vim.fn.stdpath 'config' .. '/.update-mark'
  local marker_stop_path = vim.fn.stdpath 'config' .. '/.no-update'

  if vim.fn.filereadable(marker_stop_path) == 1 then
    return
  end

  if week_passed(marker_path) then
    create_marker(marker_path)
    vim.notify('A week has passed, updating plugins...', vim.log.levels.INFO)
    vim.pack.update(nil, { force = true })
    vim.schedule(function()
      vim.notify('Plugins updated silently in background!', vim.log.levels.INFO)
    end)
  end
end

function M.timer.resume_background_checks()
  local marker_path = vim.fn.stdpath 'config' .. '/.stop-update'
  if vim.fn.filereadable(marker_path) == 1 then
    vim.fn.delete(marker_path)
  end

  M.timer.start_background_checks()
end

function M.timer.start_background_checks()
  M.timer.background_checker()

  vim.loop.new_timer():start(
    1800000,
    0,
    vim.schedule_wrap(function()
      M.timer.background_checker()
    end)
  )
end

function M.timer.stop_background_checks()
  vim.loop.timer_stop(M.timer.timer)
end

return M
