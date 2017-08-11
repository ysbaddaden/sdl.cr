
require "./window.cr"

module SDL

	class GLContext
	
		alias Attribute = LibSDL::GLattr
		alias Profile = LibSDL::GLprofile
		alias Flag = LibSDL::GLcontextFlag

		@@lib_loaded = false


		def self.load_library( path : String | Nil ) : Nil
			return if @@lib_loaded

			ret = 0

			if path.nil?
				ret = LibSDL.gl_load_library( Pointer.null )
			else
				ret = LibSDL.gl_load_library( path )
			end

			raise Error.new( "SDL_GL_LoadLibrary" ) unless ret == 0
			@@lib_loaded = true
		end

		def self.unload_library : Nil
			return unless @@lib_loaded

			LibSDL.gl_unload_library
			@@lib_loaded = false
		end

		# TODO: Maybe a generic function returning a `Proc` object ?
		# not good enough for doing it right.
		def self.get_proc_address( name : String ) : Void*
			raise Error.new( "OpenGL Library not loaded" ) unless @@lib_loaded

			LibSDL.gl_get_proc_address( name )
		end



		def self.get_attribute( attr : Attribute ) : Int
			val = 0
			ret = LibSDL.gl_get_attribute( attr, pointerof(val) )
			raise Error.new( "SDL_GL_GetAttribute" ) unless ret == 0

			return val
		end

		def self.set_attribute( attr : Attribute, val : Int ) : Nil
			ret = LibSDL.gl_set_attribute( attr, val )
			raise Error.new("SDL_GL_SetAttribute" ) unless ret == 0
		end

		def self.reset_attributes : Nil
			LibSDL.get_reset_attributes
		end



		def self.is_extension_supported?( name : String ) : Bool
			return LibSDL.gl_extension_supported( name )
		end



		def self.drawable_size( w : Window )
			LibSDL.gl_get_drawable_size( w, out w, out h )
			return { w, h }
		end


		def self.swap_window( w : Window ) : Nil
			LibSDL.gl_swap_window( w )
		end


		def self.get_swap_interval : Int
			return LibSDL.gl_get_swap_interval
		end

		def self.set_swap_interval( nv : Int ) : Nil
			ret = LibSDL.gl_set_swap_interval( nv )
			raise Error.new( "SDL_GL_SetSwapInterval" ) unless ret == 0
		end



		def initialize( window : Window )
			@context = LibSDL.gl_create_context( window )
		end

		def finalize
			LibSDL.gl_destroy_context( @context )
		end



		def make_current( w : Window ) : Nil
			ret = LibSDL.gl_make_current( w, @context )
			raise Error.new( "SDL_GL_MakeCurrent" ) unless ret == 0
		end


		def to_unsafe
			@context
		end

	end

end


