Song = Base:new()

function Song:new(song_name)
  local obj = Base.new(self)

  obj.tracks = self:parse_tracks(song_name)

  return obj
end

function Song:update(button_press_callback)
  self:play_tracks(button_press_callback)
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
        local pitch, duration, instrument, volume, effect, extra_effects = unpack(split(notes[n]))
        local duration_frames = flr(Metronome.frames_per_beat * parse_duration(duration))
        local ticks_per_note = flr((duration_frames * Metronome.ticks_per_second) / Metronome.frames_per_beat)

        parsed_notes[current_frame] = {
          pitch = parse_pitch(pitch),
          duration_frames = duration_frames,
          instrument = instrument,
          volume = volume,
          effect = effect,
          extra_effects = compute_extra_effects(extra_effects),
          beat_frame = current_frame,
          ticks_per_note = ticks_per_note,
          button = buttons[ceil(rnd(#buttons))]
        }

        current_frame += duration_frames
      end

      add(parsed_tracks, { notes = parsed_notes })
    end
  end

  return parsed_tracks
end

function Song:play_sound(sfx_id, pitch, instrument, volume, effect, extra_effects, ticks_per_note, channel)
  local base_address = 0x3200 + 68 * sfx_id
  poke(base_address, pitch + 64 * (instrument % 4))
  poke(base_address + 1, 16 * effect + 2 * volume + flr(instrument / 4))
  poke(base_address + 64, extra_effects)
  poke(base_address + 65, ticks_per_note)
  sfx(sfx_id, channel or -1, 0, 1)
end

function Song:play_tracks(button_press_callback)
  for i = 1, 4 do
    local track = self.tracks[i]

    if track then
      local note = track.notes[game.metronome.frames]

      if note then
        if note.pitch == -1 then
          self:play_sound(i + 10, 1, 0, 0, 1, 0, note.ticks_per_note, i - 1)
        else
          self:play_sound(i + 10, note.pitch, note.instrument, note.volume, note.effect, note.extra_effects, note.ticks_per_note, i - 1)
        end
      end
    end
  end
end