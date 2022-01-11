lib LibSDL
  ALPHA_OPAQUE      = 255
  ALPHA_TRANSPARENT =   0

  enum PixelType
    UNKNOWN
    INDEX1
    INDEX4
    INDEX8
    PACKED8
    PACKED16
    PACKED32
    ARRAYU8
    ARRAYU16
    ARRAYU32
    ARRAYF16
    ARRAYF32
  end

  enum BitmapOrder
    SDL_BITMAPORDER_NONE
    SDL_BITMAPORDER_4321
    SDL_BITMAPORDER_1234
  end

  enum PackedOrder
    NONE
    XRGB
    RGBX
    ARGB
    RGBA
    XBGR
    BGRX
    ABGR
    BGRA
  end

  enum ArrayOrder
    NONE
    RGB
    RGBA
    ARGB
    BGR
    BGRA
    ABGR
  end

  enum PackedLayout
    NONE
    L332
    L4444
    L1555
    L5551
    L565
    L8888
    L2101010
    L1010102
  end

  # macro define_pixelfourcc(a, b, c, d)
  #  {{a}}.ord.to_u32 << 0 |
  #  {{b}}.ord.to_u32 << 8 |
  #  {{c}}.ord.to_u32 << 16 |
  #  {{d}}.ord.to_u32 << 24
  # end

  # macro define_pixelformat(type, order, layout, bits, bytes)
  #  ((1 << 28) | ({{type}} << 24) | ({{order}} << 20) | ({{layout}} << 16) | ({{bits}} << 8) | ({{bytes}} << 0))
  # end

  enum PixelFormatEnum : UInt32
    UNKNOWN
    INDEX1LSB   = 1 << 28 | PixelType::INDEX1 << 24 | BitmapOrder::SDL_BITMAPORDER_4321 << 20 | 0 << 16 | 1 << 8 | 0
    INDEX1MSB   = 1 << 28 | PixelType::INDEX1 << 24 | BitmapOrder::SDL_BITMAPORDER_1234 << 20 | 0 << 16 | 1 << 8 | 0
    INDEX4LSB   = 1 << 28 | PixelType::INDEX4 << 24 | BitmapOrder::SDL_BITMAPORDER_4321 << 20 | 0 << 16 | 4 << 8 | 0
    INDEX4MSB   = 1 << 28 | PixelType::INDEX4 << 24 | BitmapOrder::SDL_BITMAPORDER_1234 << 20 | 0 << 16 | 4 << 8 | 0
    INDEX8      = 1 << 28 | PixelType::INDEX8 << 24 | 0 << 20 | 0 << 16 | 8 << 8 | 1
    RGB332      = 1 << 28 | PixelType::PACKED8 << 24 | PackedOrder::XRGB << 20 | PackedLayout::L332 << 16 | 8 << 8 | 1
    RGB444      = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::XRGB << 20 | PackedLayout::L4444 << 16 | 12 << 8 | 2
    RGB555      = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::XRGB << 20 | PackedLayout::L1555 << 16 | 15 << 8 | 2
    BGR555      = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::XBGR << 20 | PackedLayout::L1555 << 16 | 15 << 8 | 2
    ARGB4444    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::ARGB << 20 | PackedLayout::L4444 << 16 | 16 << 8 | 2
    RGBA4444    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::RGBA << 20 | PackedLayout::L4444 << 16 | 16 << 8 | 2
    ABGR4444    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::ABGR << 20 | PackedLayout::L4444 << 16 | 16 << 8 | 2
    BGRA4444    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::BGRA << 20 | PackedLayout::L4444 << 16 | 16 << 8 | 2
    ARGB1555    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::ARGB << 20 | PackedLayout::L1555 << 16 | 16 << 8 | 2
    RGBA5551    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::RGBA << 20 | PackedLayout::L5551 << 16 | 16 << 8 | 2
    ABGR1555    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::ABGR << 20 | PackedLayout::L1555 << 16 | 16 << 8 | 2
    BGRA5551    = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::BGRA << 20 | PackedLayout::L5551 << 16 | 16 << 8 | 2
    RGB565      = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::XRGB << 20 | PackedLayout::L565 << 16 | 16 << 8 | 2
    BGR565      = 1 << 28 | PixelType::PACKED16 << 24 | PackedOrder::XBGR << 20 | PackedLayout::L565 << 16 | 16 << 8 | 2
    RGB24       = 1 << 28 | PixelType::ARRAYU8 << 24 | ArrayOrder::RGB << 20 | 0 << 16 | 24 << 8 | 3
    BGR24       = 1 << 28 | PixelType::ARRAYU8 << 24 | ArrayOrder::BGR << 20 | 0 << 16 | 24 << 8 | 3
    RGB888      = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::XRGB << 20 | PackedLayout::L8888 << 16 | 24 << 8 | 4
    RGBX8888    = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::RGBX << 20 | PackedLayout::L8888 << 16 | 24 << 8 | 4
    BGR888      = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::XBGR << 20 | PackedLayout::L8888 << 16 | 24 << 8 | 4
    BGRX8888    = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::BGRX << 20 | PackedLayout::L8888 << 16 | 24 << 8 | 4
    ARGB8888    = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::ARGB << 20 | PackedLayout::L8888 << 16 | 32 << 8 | 4
    RGBA8888    = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::RGBA << 20 | PackedLayout::L8888 << 16 | 32 << 8 | 4
    ABGR8888    = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::ABGR << 20 | PackedLayout::L8888 << 16 | 32 << 8 | 4
    BGRA8888    = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::BGRA << 20 | PackedLayout::L8888 << 16 | 32 << 8 | 4
    ARGB2101010 = 1 << 28 | PixelType::PACKED32 << 24 | PackedOrder::ARGB << 20 | PackedLayout::L2101010 << 16 | 32 << 8 | 4
    YV12        =  842094169
    IYUV        = 1448433993
    YUY2        =  844715353
    UYVY        = 1498831189
    YVYU        = 1431918169
  end

  alias Color = SDL::Color

  struct Palette
    ncolors : Int
    colors : Color*
    version : UInt32
    refcount : Int
  end

  struct PixelFormat
    format : UInt32
    palette : Palette*
    bitsPerPixel : UInt8
    bytesPerPixel : UInt8
    padding : UInt8[2]
    r_mask : UInt32
    g_mask : UInt32
    b_mask : UInt32
    a_mask : UInt32
    r_loss : UInt8
    g_loss : UInt8
    b_loss : UInt8
    a_loss : UInt8
    r_shift : UInt8
    g_shift : UInt8
    b_shift : UInt8
    a_shift : UInt8
    refcount : Int
    next : PixelFormat*
  end

  fun get_pixel_format_name = SDL_GetPixelFormatName(format : UInt32) : Char*
  fun pixel_format_enum_to_masks = SDL_PixelFormatEnumToMasks(format : UInt32, bpp : Int*, r_mask : UInt32*, g_mask : UInt32*, b_mask : UInt32*, a_mask : UInt32*) : Bool
  fun masks_to_pixel_format_enum = SDL_MasksToPixelFormatEnum(bpp : Int, r_mask : UInt32, g_mask : UInt32, b_mask : UInt32, a_mask : UInt32) : UInt32
  fun alloc_format = SDL_AllocFormat(pixel_format : UInt32) : PixelFormat*
  fun free_format = SDL_FreeFormat(format : PixelFormat*)

  fun alloc_palette = SDL_AllocPalette(ncolors : Int) : Palette*
  fun set_pixel_format_palette = SDL_SetPixelFormatPalette(format : PixelFormat*, palette : Palette*) : Int
  fun set_palette_colors = SDL_SetPaletteColors(palette : Palette*, colors : Color*, firstcolor : Int, ncolors : Int) : Int
  fun free_palette = SDL_FreePalette(palette : Palette*)

  fun map_rgb = SDL_MapRGB(format : PixelFormat*, r : UInt8, g : UInt8, b : UInt8) : UInt32
  fun map_rgba = SDL_MapRGBA(format : PixelFormat*, r : UInt8, g : UInt8, b : UInt8, a : UInt8) : UInt32
  fun get_rgb = SDL_GetRGB(pixel : UInt32, format : PixelFormat*, r : UInt8*, g : UInt8*, b : UInt8*)
  fun get_rgba = SDL_GetRGBA(pixel : UInt32, format : PixelFormat*, r : UInt8*, g : UInt8*, b : UInt8*, a : UInt8*)
  fun calculate_gamma_ramp = SDL_CalculateGammaRamp(gamma : Float, ramp : UInt16*)
end
