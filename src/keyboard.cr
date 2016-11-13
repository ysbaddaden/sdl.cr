module SDL
  def self.enable_key_repeat(delay = LibSDL::DEFAULT_REPEAT_DELAY, interval = LibSDL::DEFAULT_REPEAT_INTERVAL)
    if LibSDL.enable_key_repeat(delay, interval) == -1
      raise Error.new("SDL_EnableKeyRepeat")
    end
  end

  def self.disable_key_repeat
    enable_key_repeat(0, 0)
  end
end
