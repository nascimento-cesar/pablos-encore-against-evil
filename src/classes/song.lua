Song = Base:new()
Song.frames_per_beat = 90
Song.ticks_per_second = 180

function Song:new(song_name)
  local obj = Base.new(self)

  obj.frames = 0
  obj.tracks = self:parse_tracks(song_name)

  return obj
end

function Song:update(button_press_callback)
  for i = 1, 4 do
    local track = self.tracks[i]

    if track then
      local channel_is_muted = stat(46 + (i - 1)) == -1

      if channel_is_muted then
        local note = track.notes[track.current_note]

        if note then
          local pitch, duration_frames, instrument, volume, effect, current_frame, ticks_per_note, button = unpack(note)

          if pitch == -1 then
            self:play_note(i, 1, 0, 0, 1, i - 1, ticks_per_note)
          else
            self:play_note(i, pitch, instrument, volume, effect, i - 1, ticks_per_note)
          end

          track.current_note += 1
        end
      end
    end
  end

  self.frames += 1
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
        local duration_frames = flr(Song.frames_per_beat * parse_duration(duration))
        local ticks_per_note = flr((duration_frames * Song.ticks_per_second) / Song.frames_per_beat)
        add(parsed_notes, { parse_pitch(pitch), duration_frames, instrument, volume, effect, current_frame, ticks_per_note, buttons[ceil(rnd(#buttons))] })
        current_frame += duration_frames
      end

      add(parsed_tracks, { current_note = 1, notes = parsed_notes })
    end
  end

  return parsed_tracks
end

function Song:play_note(sfx_id, pitch, instrument, volume, effect, channel, ticks_per_note)
  local base_address = 0x3200 + 68 * sfx_id
  poke(base_address, pitch + 64 * (instrument % 4))
  poke(base_address + 1, 16 * effect + 2 * volume + flr(instrument / 4))
  poke(base_address + 65, ticks_per_note)
  sfx(sfx_id, channel or -1)
end