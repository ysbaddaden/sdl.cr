require "./window.cr"

module SDL
  class GLContext
    alias Attribute = LibSDL::GLattr
    alias Profile = LibSDL::GLprofile
    alias Flag = LibSDL::GLcontextFlag

    @@library_loaded = false

    def self.load_library(path)
      return if @@library_loaded

      ret = 0

      ret = LibSDL.gl_load_library(path)

      raise Error.new("SDL_GL_LoadLibrary") unless ret == 0
      @@library_loaded = true
      nil
    end

    def self.unload_library
      # Maybe raise an error ?
      return unless @@library_loaded

      LibSDL.gl_unload_library
      @@library_loaded = false
      nil
    end

    # TODO: Maybe a generic function returning a `Proc` object ?
    # not good enough for doing it right.
    def self.get_proc_address(name)
      raise Error.new("OpenGL Library not loaded") unless @@library_loaded

      LibSDL.gl_get_proc_address(name)
    end

    def self.get_attribute(attribute)
      val = 0
      ret = LibSDL.gl_get_attribute(attribute, pointerof(val))
      raise Error.new("SDL_GL_GetAttribute") unless ret == 0

      val
    end

    def self.set_attribute(attribute, value)
      ret = LibSDL.gl_set_attribute(attribute, value)
      raise Error.new("SDL_GL_SetAttribute") unless ret == 0
    end

    def self.reset_attributes
      LibSDL.get_reset_attributes
    end

    def self.is_extension_supported?(name)
      LibSDL.gl_extension_supported(name)
    end

    def self.drawable_size(window)
      LibSDL.gl_get_drawable_size(window, out w, out h)
      {w, h}
    end

    def self.swap_window(window) : Nil
      LibSDL.gl_swap_window(w)
    end

    def self.swap_interval
      LibSDL.gl_get_swap_interval
    end

    def self.swap_interval=(interval)
      ret = LibSDL.gl_set_swap_interval(interval)
      raise Error.new("SDL_GL_SetSwapInterval") unless ret == 0

      interval
    end

    def initialize(window)
      @context = LibSDL.gl_create_context(window)
    end

    def finalize
      LibSDL.gl_destroy_context(@context)
    end

    def make_current(window)
      ret = LibSDL.gl_make_current(window, @context)
      raise Error.new("SDL_GL_MakeCurrent") unless ret == 0
    end

    def to_unsafe
      @context
    end
  end
end
