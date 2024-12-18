Player = Base:new()

function Player:new()
  local obj = Base.new(self)

  obj.button_states = {}
  obj.combo = 0
  obj.multiplier = 1
  obj.score = 0

  return obj
end

function Player:update()
  for button_icon in all(split "❎,🅾️,⬅️,⬇️,➡️") do
    self.button_states[button_icon] = btn(get_button_id(button_icon))
  end
end

function Player:score_up(frame_type)
  self.score += (frame_type == "perfect" and 20 or 10) * self.multiplier
  self.combo += 1
end