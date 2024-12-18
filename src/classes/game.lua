Game = Base:new()

function Game:new()
  local obj = Base.new(self)

  obj.player = Player:new()
  obj.song = Song:new("canon_rock")
  obj.metronome = Metronome:new(obj.song.song_data.bpm)

  return obj
end

function Game:update()
  self.metronome:update()
  self.player:update()
  self.song:update(self.metronome.current_beat, self.metronome.frame_type, self.handle_button_press)
end

function Game:handle_button_press()
end