Metronome = {
  new = function()
    local obj = {
      beats = 0,
      frames_per_beat = 16,
      frames = 0,
      frame_type = "",
      is_beat_frame = false
    }

    obj.update = function()
      obj.update_frames()
      obj.play_beat()
    end

    obj.play_beat = function()
      if obj.is_beat_frame then
        sfx(0)
      end
    end

    obj.update_frames = function()
      local beat_frame = obj.beats * obj.frames_per_beat
      local perfect_tolerance = ceil(obj.frames_per_beat / 10)
      local ok_tolerance = perfect_tolerance * 2

      if obj.frames >= (beat_frame - perfect_tolerance) and obj.frames <= (beat_frame + perfect_tolerance) then
        obj.frame_type = "perfect"
      elseif obj.frames >= (beat_frame - ok_tolerance) and obj.frames <= (beat_frame + ok_tolerance) then
        obj.frame_type = "ok"
      else
        obj.frame_type = "miss"
      end

      obj.is_beat_frame = obj.frames == beat_frame
      obj.beats += obj.is_beat_frame and 1 or 0
      obj.frames += 1
    end

    return obj
  end
}