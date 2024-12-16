Game = {
  new = function()
    local obj = {
      beat = 0,
      current_track = nil,
      tempo = 30
    }

    obj.draw = function()
    end

    obj.metronome = function()
      obj.beat += 1

      if (obj.beat % obj.tempo == 0) then
        sfx(0)
      end
    end

    obj.update = function()
      obj.metronome()
    end

    return obj
  end
}