Metronome = {
  new = function()
    local obj = {
      current_beat = 0,
      frames_per_beat = 32,
      frames = 0,
      frame_type = ""
    }

    obj.play_beat = function()
      if obj.frame_type == "perfect" then
        sfx(0, 0)
      end
    end

    obj.update = function()
      obj.update_frames()
      obj.play_beat()
    end

    obj.update_frames = function()
      local beat_frame = obj.current_beat * obj.frames_per_beat
      local previous_beat_frame = (obj.current_beat - 1) * obj.frames_per_beat
      local tolerance = ceil(obj.frames_per_beat / 10)

      if obj.frames == beat_frame then
        obj.frame_type = "perfect"
      elseif obj.frames >= (beat_frame - tolerance) and obj.frames <= beat_frame then
        obj.frame_type = "awesome"
      elseif obj.frames <= (previous_beat_frame + tolerance) and obj.frames >= previous_beat_frame then
        obj.frame_type = "awesome"
      elseif obj.frames >= (beat_frame - tolerance * 2) and obj.frames <= beat_frame then
        obj.frame_type = "ok"
      elseif obj.frames <= (previous_beat_frame + tolerance * 2) and obj.frames >= previous_beat_frame then
        obj.frame_type = "ok"
      else
        obj.frame_type = "miss"
      end

      obj.current_beat += obj.frame_type == "perfect" and 1 or 0
      obj.frames += 1
    end

    return obj
  end
}