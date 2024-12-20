Metronome = Base:new()
Metronome.frames_per_beat = 90
Metronome.ticks_per_second = 180
Metronome.sfx_frames_delay = 12

function Metronome:new()
  local obj = Base.new(self)

  obj.frames = 0

  return obj
end

function Metronome:update(button_press_callback)
  self.frames += 1
end