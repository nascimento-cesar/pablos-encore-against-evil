Player = {
  new = function()
    local obj = {
      button_states = {},
      combo = 0,
      multiplier = 1,
      score = 0
    }

    obj.draw = function()
    end

    obj.score_up = function(frame_type)
      obj.score += (frame_type == "perfect" and 20 or 10) * obj.multiplier
      obj.combo += 1
    end

    obj.update = function()
      for btn_id in all(split "4,5,0,1,3") do
        obj.button_states[btn_id] = btn(btn_id)
      end
    end

    return obj
  end
}