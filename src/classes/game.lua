Game = {
  new = function()
    local obj = {
      track = nil
    }

    obj.update = function()
      if not obj.track then
        obj.track = Track.new()
      end

      obj.track.update()
    end

    return obj
  end
}