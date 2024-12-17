Game = {
  new = function()
    local obj = {
      metronome = Metronome.new(),
      player = Player.new(),
      song = Song.new()
    }

    obj.update = function()
      obj.metronome.update()
      obj.player.update()
      obj.song.update(obj.metronome.current_beat, obj.metronome.frame_type, obj.player.score_up)
    end

    return obj
  end
}