require "./surface"

module SDL
  class Window
    alias Flags = LibSDL::WindowFlags
    alias Position = LibSDL::WindowPosition

    def initialize(title, width, height,
                   x : Position = Position::UNDEFINED,
                   y : Position = Position::UNDEFINED,
                   flags : Flags = Flags::SHOWN)
      @window = LibSDL.create_window(title, x, y, width, height, flags)
    end

    def finalize
      LibSDL.destroy_window(self)
    end

    def surface
      @surface ||= Surface.new(LibSDL.get_window_surface(self))
    end

    # Copies the window surface to the screen.
    def update
      LibSDL.update_window_surface(self)
    end

    def to_unsafe
      @window
    end
  end
end
