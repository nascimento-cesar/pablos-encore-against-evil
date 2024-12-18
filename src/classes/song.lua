Song = Base:new()

function Song:new(song_name)
  local obj = Base.new(self)

  obj.song_data = get_song_data(song_name)

  return obj
end

function Song:update(current_beat, frame_type, button_press_callback)
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