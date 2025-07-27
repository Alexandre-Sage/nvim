local NuiInput = require("nui.input")
local event = require("nui.utils.autocmd").event

---@param current string
---@return nui_popup_options
local function popup_options(current)
  return {
    -- default_value = vim.fn.expand("<cword>"),
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = #current > 40 and #current + 10 or 40,
    border = {
      style = "rounded",
      text = {
        top = "[Rename]",
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  }
end

---@param current string
---@return nui_input_options
local function input_options(current)
  return {

    default_value = current,
    prompt = "=> ",
    on_close = function()
      return nil
    end,
    on_submit = function(new_name)
      if new_name and #new_name > 0 then
        vim.lsp.buf.rename(new_name)
      end
    end,

    on_change = function(value)
      return nil
    end,
  }
end

local function create_input(popup_options, input_options)
  local input = NuiInput(popup_options, input_options)
  input:map("n", "<Esc>", function()
    input:unmount()
  end, { noremap = true })
  return input
end

vim.keymap.set({ "n" }, "<space>rn", function()
  local current = vim.fn.expand("<cword>")
  create_input(popup_options(current), input_options(current)):mount()
end, { desc = "Rename variable" })

vim.api.nvim_create_user_command("TestIpt", function()
  local current = vim.fn.expand("<cword>")
  create_input(popup_options(current), input_options(current)):mount()
end, {})
return {}
