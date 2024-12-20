function _draw()
  cls()
  map(0, 0, 0, 0, 16, 16)
  print_outlined_text(debug, 0, 0, 7)
  print_outlined_text(game.player.score, 0, 10, 7)
  print_outlined_text(game.metronome.frames, 0, 20, 7)
  print_buttons()
  print_tracks()
end

function print_button(button_icon, c)
  local is_button_pressed = game.player.button_states[button_icon]
  print_outlined_text(button_icon, 38 + ((get_button_index(button_icon) - 1) * 10), 118 + (is_button_pressed and 1 or 0), is_button_pressed and 7 or c)
end

function print_buttons()
  print_button("❎", 11)
  print_button("🅾️", 8)
  print_button("⬅️", 12)
  print_button("⬇️", 12)
  print_button("➡️", 12)
end

function print_outlined_text(text, x, y, c, o_c)
  for i = -1, 1 do
    for j = -1, 2 do
      print(text, x + i, y + j, o_c or 0)
    end
  end

  print(text, x, y, c)
end

function print_tracks()
  for i = 1, 4 do
    local track = game.song.tracks[i]

    if track then
      for f = game.metronome.frames, game.metronome.frames + 120 do
        local note = track.notes[f - Metronome.sfx_frames_delay]

        if note and note.pitch > -1 then
          local note_x = 38 + ((get_button_index(note.button) - 1) * 10)
          local note_y = 118 - (note.beat_frame - (game.metronome.frames - Metronome.sfx_frames_delay))

          if note_y > 80 then
            print_outlined_text(note.button, note_x, note_y, 7)
          end
        end
      end
    end
  end
end