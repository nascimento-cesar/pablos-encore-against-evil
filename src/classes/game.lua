Game = Base:new()

function Game:new()
  local obj = Base.new(self)

  obj.metronome = Metronome:new()
  obj.player = Player:new()
  obj.song = Song:new("canon_rock")

  return obj
end

function Game:update()
  self.song:update(self.handle_button_press)
  self.metronome:update()
  self.player:update()
end

function Game:handle_button_press()
end