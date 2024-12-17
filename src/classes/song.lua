Song = {
  new = function()
    local obj = {
      track = {},
      raw_track = "D2,0,6,0,16,-1,62|E2,1,6,0,16,-1,63/F2,0,6,0,16,-1,62"
    }

    obj.update = function(current_beat, frame_type, score_up_callback)
      if #obj.track == 0 then
        obj.parse_track()
      end

      if current_beat > #obj.track then
        return
      end

      if frame_type == "perfect" then
        local note_set = obj.track[current_beat]

        for i = 1, #note_set do
          obj.play_note(unpack(note_set[i]))
        end
      end
    end

    obj.parse_track = function()
      obj.track = {}
      local raw_note_sets = split(obj.raw_track, "|")

      for i = 1, #raw_note_sets do
        local raw_note_set = split(raw_note_sets[i], "/")
        local note_set = {}

        for j = 1, #raw_note_set do
          add(note_set, split(raw_note_set[j]))
        end

        add(obj.track, note_set)
      end
    end

    obj.play_note = function(pitch, instrument, volume, effect, speed, channel, sfx_id)
      local sfx_id = sfx_id or 63
      local base_address = 0x3200 + 68 * sfx_id

      for i = 0, 31 do
        poke(base_address + i * 2, 0)
      end

      poke(base_address, get_pitch_id(pitch) + 64 * (instrument % 4))
      poke(base_address + 1, 16 * effect + 2 * volume + flr(instrument / 4))
      poke(base_address + 65, speed)
      sfx(sfx_id, channel)
    end

    return obj
  end
}