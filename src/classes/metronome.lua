Metronome = Base:new()
Metronome.frames_per_beat = 64

function Metronome:new()
  local obj = Base.new(self)

  obj.current_beat = 0
  obj.frames = 0

  return obj
end

function Metronome:update()
  self.frames += 1
end