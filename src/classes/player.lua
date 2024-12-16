Player = {
  new = function()
    local obj = {
      button_states = {}
    }

    obj.draw = function()
      local i = 0
      for button, state in pairs(obj.button_states) do
        print(button .. " - " .. (state and "t" or "f"), 0, i)
        i += 10
      end
    end

    obj.update = function()
      for btn_id in all(split "4,5,0,1,3") do
        obj.button_states[btn_id] = btn(btn_id)
      end
    end

    return obj
  end
}