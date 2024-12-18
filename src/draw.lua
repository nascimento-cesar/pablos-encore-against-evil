function _draw()
  cls()
  map(0, 0, 0, 0, 16, 16)
  print_outlined_text(debug, 0, 0, 7)
  print_outlined_text(game.metronome.frame_type, 0, 10, 7)
  print_outlined_text(game.player.score, 0, 20, 7)
  print_button("❎", 0, 11)
  print_button("🅾️", 1, 8)
  print_button("⬅️", 2, 12)
  print_button("⬇️", 3, 12)
  print_button("➡️", 4, 12)
end

function print_button(button_icon, i, c)
  local is_button_pressed = game.player.button_states[button_icon]
  print_outlined_text(button_icon, 38 + (i * 10), 112 + (is_button_pressed and 1 or 0), is_button_pressed and 7 or c)
end

function print_outlined_text(text, x, y, c, o_c)
  for i = -1, 1 do
    for j = -1, 2 do
      print(text, x + i, y + j, o_c or 0)
    end
  end

  print(text, x, y, c)
end