Game = {
  new = function()
    local obj = {
      metronome = Metronome.new(),
      player = Player.new(),
      song = Song.new()
    }

    obj.draw = function()
      print(debug, 0, 0, 7)
      print(obj.metronome.frame_type, 0, 10, 7)
      print(obj.player.score, 0, 20, 7)
    end

    obj.update = function()
      obj.metronome.update()
      obj.player.update()
      obj.song.update(obj.metronome.current_beat, obj.metronome.frame_type, obj.player.score_up)
    end

    return obj
  end
}