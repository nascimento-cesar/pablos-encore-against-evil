Player = {
  new = function()
    local obj = {
      button_states = {},
      combo = 0,
      multiplier = 1,
      score = 0
    }

    obj.score_up = function(frame_type)
      obj.score += (frame_type == "perfect" and 20 or 10) * obj.multiplier
      obj.combo += 1
    end

    obj.update = function()
      for button_icon in all(split "❎,🅾️,⬅️,⬇️,➡️") do
        obj.button_states[button_icon] = btn(get_button_id(button_icon))
      end
    end

    return obj
  end
}