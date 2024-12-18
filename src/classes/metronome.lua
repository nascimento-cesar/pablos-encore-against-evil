Metronome = Base:new()

function Metronome:new(bpm)
  local obj = Base.new(self)

  obj.current_beat = 0
  obj.frames_per_beat = flr(64 * 60 / bpm)
  obj.frames = 0
  obj.frame_type = ""

  return obj
end

function Metronome:update()
  self:update_frames()
  self:play_beat()
end

function Metronome:play_beat()
  if self.frame_type == "perfect" then
    sfx(0, 0)
  end
end

function Metronome:update_frames()
  local beat_frame = self.current_beat * self.frames_per_beat
  local previous_beat_frame = (self.current_beat - 1) * self.frames_per_beat
  local tolerance = ceil(self.frames_per_beat / 10)

  if self.frames == beat_frame then
    self.frame_type = "perfect"
  elseif self.frames >= (beat_frame - tolerance) and self.frames <= beat_frame then
    self.frame_type = "awesome"
  elseif self.frames <= (previous_beat_frame + tolerance) and self.frames >= previous_beat_frame then
    self.frame_type = "awesome"
  elseif self.frames >= (beat_frame - tolerance * 2) and self.frames <= beat_frame then
    self.frame_type = "ok"
  elseif self.frames <= (previous_beat_frame + tolerance * 2) and self.frames >= previous_beat_frame then
    self.frame_type = "ok"
  else
    self.frame_type = "miss"
  end

  self.current_beat += self.frame_type == "perfect" and 1 or 0
  self.frames += 1
end