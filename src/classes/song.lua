Song = Base:new()

function Song:new(song_name)
  local obj = Base.new(self)

  obj.tracks = self:parse_tracks(song_name)

  return obj
end

function Song:update(metronome, button_press_callback)
  for i = 1, 4 do
    local track = self.tracks[i]

    if track then
      local note = track.notes[metronome.frames]

      if note then
        local pitch, duration_frames, instrument, volume, effect, current_frame, button = unpack(note)

        if pitch == -1 then
          sfx(pitch, i - 1)
        else
          self:play_note(i, pitch, instrument, volume, effect, i - 1, duration_frames)
        end
      end
    end
  end
end

function Song:parse_tracks(song_name)
  local parsed_tracks = {}

  for t = 1, 4 do
    local track = get_song_tracks(song_name)[t]

    if track then
      local current_frame = 0
      local parsed_notes = {}
      local buttons = "❎🅾️⬅️⬇️➡️"
      local notes = split(track, "|")

      for n = 1, #notes do
        local pitch, duration, instrument, volume, effect = unpack(split(notes[n]))
        local duration_frames = Metronome.frames_per_beat * parse_duration(duration)
        parsed_notes[current_frame] = { parse_pitch(pitch), duration_frames, instrument, volume, effect, current_frame, buttons[ceil(rnd(#buttons))] }
        current_frame += duration_frames
      end

      add(parsed_tracks, { notes = parsed_notes })
    end
  end

  return parsed_tracks
end

function Song:play_note(sfx_id, pitch, instrument, volume, effect, channel, duration)
  local base_address = 0x3200 + 68 * sfx_id
  poke(base_address, pitch + 64 * (instrument % 4))
  poke(base_address + 1, 16 * effect + 2 * volume + flr(instrument / 4))
  poke(base_address + 65, 1)
  sfx(sfx_id, channel or -1)
end