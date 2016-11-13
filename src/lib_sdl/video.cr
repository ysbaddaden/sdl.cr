lib LibSDL
  ALPHA_OPAQUE = 255
  ALPHA_TRANSPARENT = 0

  struct Rect
    x : Int16
    y : Int16
    w : UInt16
    h : UInt16
  end

  struct Color
    r : UInt8
    g : UInt8
    b : UInt8
    unused : UInt8
  end

  struct Palette
    ncolors : Int
    colors : Color*
  end

  struct PixelFormat
    palette : Palette*
    bits_per_pixel : UInt8
    bytes_per_pixel : UInt8

    r_loss : UInt8
    g_loss : UInt8
    b_loss : UInt8
    a_loss : UInt8

    r_shift : UInt8
    g_shift : UInt8
    b_shift : UInt8
    a_shift : UInt8

    r_mask : UInt32
    g_mask : UInt32
    b_mask : UInt32
    a_mask : UInt32

    colorkey : UInt32
    alpha : UInt8
  end

  struct Surface
    flags : UInt32
    format : PixelFormat*
    w : Int
    h : Int
    pitch : UInt16
    pixels : Void*
    __offset : Int
    __private_hwdata : Void*
    clip_rect : Rect
    __unused1 : UInt32
    __locked : UInt32
    __map : Void*
    __format_version : UInt
    refcount : Int
  end

  # available for SDL_CreateRGBSurface or SDL_SetVideoMode

  SWSURFACE = 0x00000000
  HWSURFACE = 0x00000001
  ASYNCBLIT = 0x00000004

  # available for SDL_SetVideoMode

  ANYFORMAT  = 0x10000000
  HWPALETTE  = 0x20000000
  DOUBLEBUF  = 0x40000000
  FULLSCREEN = 0x80000000
  OPENGL     = 0x00000002
  OPENGLBLIT = 0x0000000A
  RESIZABLE  = 0x00000010
  NOFRAME    = 0x00000020

  # used internally (read-only)

  HWACCEL     = 0x00000100
  SRCCOLORKEY = 0x00001000
  RLEACCELOK  = 0x00002000
  RLEACCEL    = 0x00004000
  SRCALPHA    = 0x00010000
  PREALLOC    = 0x01000000

  struct VideoInfo
    flags : UInt32
	#hw_available : UInt32 :1
	#wm_available : UInt32 :1
	#__unused_bits1 : UInt32 :6
	#__unused_bits2 : UInt32 :1
	#blit_hw : UInt32 :1
	#blit_hw_CC : UInt32 :1
	#blit_hw_A : UInt32 :1
	#blit_sw : UInt32 :1
	#blit_sw_CC : UInt32 :1
	#blit_sw_A : UInt32 :1
	#blit_fill : UInt32 :1
	#__unused_bits3 : UInt32 :16
	video_mem : UInt32
	vfmt : PixelFormat*
	current_w : Int
	current_h : Int
  end

  # overlay
  YV12_OVERLAY = 0x32315659
  IYUV_OVERLAY = 0x56555949
  YUY2_OVERLAY = 0x32595559
  UYVY_OVERLAY = 0x59565955
  YVYU_OVERLAY = 0x55595659

  struct Overlay
    format : UInt32
    w : Int
    h : Int
    planes : Int
    pitches : UInt16*
    pixels : UInt8**
	hwfuncs : Void*
	hwdata : Void*
	hw_overlay : UInt32 # :1
	#UnusedBits : UInt32 # :31
  end

  enum GLattr
    RED_SIZE
    GREEN_SIZE
    BLUE_SIZE
    ALPHA_SIZE
    BUFFER_SIZE
    DOUBLEBUFFER
    DEPTH_SIZE
    STENCIL_SIZE
    ACCUM_RED_SIZE
    ACCUM_GREEN_SIZE
    ACCUM_BLUE_SIZE
    ACCUM_ALPHA_SIZE
    STEREO
    MULTISAMPLEBUFFERS
    MULTISAMPLESAMPLES
    ACCELERATED_VISUAL
    SWAP_CONTROL
  end

  LOGPAL = 0x01
  PHYSPAL = 0x02

  fun video_init = SDL_VideoInit(driver_name : Char*, flags: UInt32) : Int
  fun video_quit = SDL_VideoQuit()
  fun video_driver_name = SDL_VideoDriverName(namebuf : Char*, maxlen : Int)
  fun get_video_surface = SDL_GetVideoSurface() : Surface*
  fun get_video_info = SDL_GetVideoInfo() : VideoInfo*
  fun video_mode_ok = SDL_VideoModeOK(width : Int, height : Int, bpp : Int, flags : UInt32) : Int
  fun list_modes = SDL_ListModes(format : PixelFormat*, flags : UInt32) : Rect**
  fun set_video_mode = SDL_SetVideoMode(width : Int, height : Int, bpp : Int, flags : UInt32) : Surface*

  fun update_rects(screen : Surface*, numrects : Int, rects : Rect*)
  fun update_rect(screen : Surface*, x : Int32, y : Int32, w : UInt32, h : UInt32)
  fun flip = SDL_Flip(screen : Surface*) : Int

  fun set_gamma = SDL_SetGamma(red : Float, green : Float, blue : Float);
  fun set_gamma_ramp = SDL_SetGammaRamp(red : UInt16*, green : UInt16*, blue : UInt16*)
  fun get_gamme_ramp = SDL_GetGammaRamp(red : UInt16*, green : UInt16*, blue : UInt16*)
  fun set_colors = SDL_SetColors(surface : Surface*, colors : Color*, firstcolor : Int, ncolors : Int);
  fun set_palette = SDL_SetPalette(surface : Surface*, flags : Int, colors : Color*, firstcolor : Int, ncolors : Int)
  fun map_rgb = SDL_MapRGB(format : PixelFormat*, r : UInt8, g : UInt8, b : UInt8, a : UInt8 ) : UInt32
  fun map_rgba = SDL_MapRGBA(format : PixelFormat*, r : UInt8, g : UInt8, b : UInt8, a : UInt8 ) : UInt32
  fun get_rgb = SDL_GetRGB(pixel : UInt32, fmt : PixelFormat*, r : UInt8*, g : UInt8*, b : UInt8*)
  fun get_rgba = SDL_GetRGBA(pixel : UInt32, fmt : PixelFormat*, r : UInt8*, g : UInt8*, b : UInt8*, a : UInt8 *)

  fun create_rgb_surface = SDL_CreateRGBSurface(flags : UInt32, width : Int, height : Int, depth : Int, r_mask : UInt32, g_mask : UInt32, b_mask : UInt32, a_mask : UInt32) : Surface*
  fun create_rgb_surface_from = SDL_CreateRGBSurfaceFrom(pixels : Void*, flags : UInt32, width : Int, height : Int, depth : Int, r_mask : UInt32, g_mask : UInt32, b_mask : UInt32, a_mask : UInt32) : Surface*
  fun free_surface = SDL_FreeSurface(surface : Surface*)
  fun lock_surface = SDL_LockSurface(surface : Surface*) : Int
  fun unlock_surface = SDL_UnlockSurface(surface : Surface*)

  fun load_bmp_rw = SDL_LoadBMP_RW(src : RWops*, freesrc : Int) : Surface*
  fun save_bmp_rw = SDL_SaveBMP_RW (surface : Surface*, dst : RWops*, freedst : Int) : Int

  fun set_color_key = SDL_SetColorKey(surface : Surface*, flag : UInt32, key : UInt32) : Int
  fun set_alpha = SDL_SetAlpha(surface : Surface*, flag : UInt32, alpha : UInt8) : Int
  fun set_clip_rect = SDL_SetClipRect(surface : Surface *, rect : Rect*) : Int # SDL_bool
  fun get_clip_rect = SDL_GetClipRect(surface : Surface *, rect : Rect*)
  fun convert_surface = SDL_ConvertSurface(src : Surface*, fmt : PixelFormat*, flags : UInt32) : Surface*
  fun upper_blit = SDL_UpperBlit(src : Surface*, srcrect : Rect*, dst : Surface*, dstrect : Rect*) : Int
  fun lower_blit = SDL_LowerBlit(src : Surface*, srcrect : Rect*, dst : Surface*, dstrect : Rect*) : Int
  fun fill_rect = SDL_FillRect(dst : Surface*, dstrect : Rect*, color : UInt32) : Int
  fun display_format = SDL_DisplayFormat(surface : Surface*) : Surface*
  fun display_format_alpha = SDL_DisplayFormatAlpha(surface : Surface*) : Surface*

  # overlay

  fun create_yuv_overlay = SDL_CreateYUVOverlay(width : Int, height : Int, format : UInt32, display : Surface*) : Overlay*
  fun lock_yuv_overlay = SDL_LockYUVOverlay(overlay : Overlay*) : Int
  fun unlock_yuv_overlay = SDL_UnlockYUVOverlay(overlay : Overlay*)
  fun display_yuv_overlay = SDL_DisplayYUVOverlay(overlay : Overlay*, dstrect : Rect*) : Int
  fun free_yuv_overlay = SDL_FreeYUVOverlay(overlay : Overlay*)

  # OpenGL support function

  fun gl_load_library = SDL_GL_LoadLibrary(path : Char*) : Int
  fun gl_get_proc_address = SDL_GL_GetProcAddress(proc : Char*) : Void*
  fun gl_get_attribute = SDL_GL_GetAttribute(attr : GLattr, value : Int*) : Int
  fun gl_set_attribute = SDL_GL_SetAttribute(attr : GLattr, value : Int) : Int
  fun gl_swap_buffers = SDL_GL_SwapBuffers()
  fun gl_update_rects = SDL_GL_UpdateRects(numrects : Int, rects : Rect*)
  fun gl_lock = SDL_GL_Lock()
  fun gl_unlock = SDL_GL_Unlock()

  # Window Manager

  fun wm_set_caption = SDL_WM_SetCaption(title : Char*, icon : Char*)
  fun wm_get_caption = SDL_WM_GetCaption(title : Char**, icon : Char**)
  fun wm_set_icon = SDL_WM_SetIcon(icon : Surface*, mask : UInt8)
  fun wm_iconify_window = SDL_WM_IconifyWindow()
  fun wm_toggle_full_screen = SDL_WM_ToggleFullScreen(surface : Surface*)

  enum GrabMode
	QUERY = -1
	OFF = 0
	ON = 1
	FULLSCREEN # used internally
  end
  fun wm_grab_input = SDL_WM_GrabInput(mode : GrabMode) : GrabMode

  fun soft_stretch = SDL_SoftStretch(src : Surface*, srcrect : Rect*, dst : Surface*, dstrect : Rect*) : Int
end
