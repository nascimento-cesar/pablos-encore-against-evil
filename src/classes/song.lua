Song = Base:new()

function Song:new(track_name)
  local obj = Base.new(self)

  obj.track = get_track(track_name)

  return obj
end

function Song:update(current_beat, frame_type, score_up_callback)
  if #self.track == 0 then
    -- self.parse_track()
  end

  if current_beat > #self.track then
    return
  end

  if frame_type == "perfect" then
    local note_set = self.track[current_beat]

    for i = 1, #note_set do
      self.play_note(unpack(note_set[i]))
    end
  end
end

function Song:parse_track()
  local raw_note_sets = split(self.raw_track, "|")

  for i = 1, #raw_note_sets do
    local raw_note_set = split(raw_note_sets[i], "/")
    local note_set = {}

    for j = 1, #raw_note_set do
      add(note_set, split(raw_note_set[j]))
    end

    add(self.track, note_set)
  end
end

function Song:play_note(sfx_id, pitch, instrument, volume, effect, speed, channel)
  local base_address = 0x3200 + 68 * sfx_id

  for i = 0, 31 do
    poke(base_address + i * 2, 0)
  end

  poke(base_address, get_pitch_id(pitch) + 64 * (instrument % 4))
  poke(base_address + 1, 16 * effect + 2 * volume + flr(instrument / 4))
  poke(base_address + 65, speed)
  sfx(sfx_id, channel or -1)
end