Game = Base:new()

function Game:new()
  local obj = Base.new(self)

  obj.player = Player:new()
  obj.song = Song:new("canon_rock")
  obj.metronome = Metronome:new()

  return obj
end

function Game:update()
  self.player:update()
  self.song:update(self.metronome, self.handle_button_press)
  self.metronome:update()
end

function Game:handle_button_press()
end