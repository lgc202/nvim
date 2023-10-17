local status, alpha = pcall(require, "alpha")
if not status then
  vim.notify("not found alpha")
  return
end

local status, dashboard = pcall(require, "alpha.themes.dashboard")
if not status then
  return
end

local status, plenary_path = pcall(require, "plenary.path")
if not status then
  return
end

local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local nvim_web_devicons = {
  enabled = true,
  highlight = true,
}

local function get_extension(fn)
  local match = fn:match("^.+(%..+)$")
  local ext = ""
  if match ~= nil then
    ext = match:sub(2)
  end
  return ext
end

local function icon(fn)
  local nwd = require("nvim-web-devicons")
  local ext = get_extension(fn)
  return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn, autocd)
  short_fn = short_fn or fn
  local ico_txt
  local fb_hl = {}

  if nvim_web_devicons.enabled then
    local ico, hl = icon(fn)
    local hl_option_type = type(nvim_web_devicons.highlight)
    if hl_option_type == "boolean" then
      if hl and nvim_web_devicons.highlight then
        table.insert(fb_hl, { hl, 0, 3 })
      end
    end
    if hl_option_type == "string" then
      table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
    end
    ico_txt = ico .. "  "
  else
    ico_txt = ""
  end
  local cd_cmd = (autocd and " | cd %:p:h" or "")
  local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. cd_cmd .. " <CR>")
  local fn_start = short_fn:match(".*[/\\]")
  if fn_start ~= nil then
    table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
  end
  file_button_el.opts.hl = fb_hl
  return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
  autocd = false,
}

--- @param start number
--- @param cwd string? optional
--- @param items_number number? optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
  opts = opts or mru_opts
  items_number = if_nil(items_number, 6)

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      oldfiles[#oldfiles + 1] = v
    end
  end
  local target_width = 35

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn
    if cwd then
      short_fn = vim.fn.fnamemodify(fn, ":.")
    else
      short_fn = vim.fn.fnamemodify(fn, ":~")
    end

    if #short_fn > target_width then
      short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
      if #short_fn > target_width then
        short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
      end
    end

    local shortcut = tostring(i + start - 1)

    local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
    tbl[i] = file_button_el
  end
  return {
    type = "group",
    val = tbl,
    opts = {},
  }
end

local section_mru = {
  type = "group",
  val = {
    {
      type = "text",
      val = "Recent files",
      opts = {
        hl = "SpecialComment",
        shrink_margin = false,
        position = "center",
      },
    },
    { type = "padding", val = 1 },
    {
      type = "group",

      val = function()
        return { mru(0, cdir) }
      end,
      opts = { shrink_margin = true },
    },
  },
}

local header = {
  type = "text",
  val = {
    [[                                  __                   ]],
    [[     ___     ___    ___   __  __ /\_\    ___ ___       ]],
    [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\     ]],
    [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \    ]],
    [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\   ]],
    [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/   ]],
  },
  opts = {
    position = "center",
    hl = "Type",
    -- wrap = "overflow";
  },
}

-- local function get_extension(fn)
--     local match = fn:match("^.+(%..+)$")
--     local ext = ""
--     if match ~= nil then
--         ext = match:sub(2)
--     end
--     return ext
-- end
--
-- local function icon(fn)
--     local nwd = require("nvim-web-devicons")
--     local ext = get_extension(fn)
--     return nwd.get_icon(fn, ext, { default = true })
-- end

--- @param key string
--- @param txt string
--- @param callback function? optional
local function button(key, txt, callback)
  local sc_ = key:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    shortcut = key,
    cursor = 3,
    width = 50,
    align_shortcut = "right",
    hl_shortcut = "Keyword",
  }

  local function on_press()
    if callback then
      vim.api.nvim_buf_delete(0, {})

      callback()
    end
  end
  local keybind_opts = { noremap = true, silent = true, nowait = true, callback = on_press }
  opts.keymap = { "n", sc_, "", keybind_opts }

  return {
    type = "button",
    val = txt,
    on_press = on_press,
    opts = opts,
  }
end

local buttons = {
  type = "group",
  val = {
    { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
    { type = "padding", val = 1 },
    button("e", "  New file", function()
      vim.cmd([[ene]])
    end),
    button("c", "  Configuration", function()
      vim.cmd([[e ~/.config/nvim/init.lua]])
    end),
    button("u", "  Update plugins", function()
      vim.cmd([[Lazy sync]])
    end),
  },
  position = "center",
}

local theme = {
  layout = {
    { type = "padding", val = 2 },
    header,
    { type = "padding", val = 2 },
    section_mru,
    { type = "padding", val = 2 },
    buttons,
  },
  opts = {
    margin = 5,
    setup = function()
      vim.api.nvim_create_autocmd("DirChanged", {
        pattern = "*",
        group = "alpha_temp",
        callback = function()
          require("alpha").redraw()
        end,
      })
    end,
  },
}

alpha.setup(theme)
