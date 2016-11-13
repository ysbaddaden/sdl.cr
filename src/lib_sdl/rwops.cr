@[Link("SDL")]
lib LibSDL
  struct RWops_win32io
    append : Int
    h : Void*
    buffer_data : Void*
    buffer_size : Int
    buffer_left : Int
  end

  struct RWops_stdio
    autoclose : Int
    fp : FILE*
  end

  struct RWops_mem
    base : UInt8*
    here : UInt8*
    stop : UInt8*
  end

  union RWops_hidden
    {% if flag?(:windows) %}
      win32io : RWops_win32io
    {% else %}
      stdio : RWops_stdio
    {% end %}
    mem : RWops_mem
    unknown : Void*
  end

  struct RWops
	seek : (RWops*, Int, Int) -> Int         # (context, offset, whence)
    read : (RWops*, Void*, Int, Int) -> Int  # (context, ptr, size, maxnum)
    write : (RWops*, Void*, Int, Int) -> Int # (context, ptr, size, num)
    close : (RWops*) -> Int                  # (context)
	type : UInt32
    hidden : RWops_hidden
  end

  fun rw_from_file = SDL_RWFromFile(file : Char*, mode : Char*) : RWops*

  {% unless flag?(:windows) %}
    fun rw_from_fp = SDL_RWFromFP(fp : FILE*, autoclose : Int) : RWops*
  {% end %}

  fun rw_from_mem = SDL_RWFromMem(mem : Void*, size : Int) : RWops*
  fun rw_from_const_mem = SDL_RWFromConstMem(mem : Void*, size : Int) : RWops*
  fun alloc_rw = SDL_AllocRW() : RWops*
  SDL_FreeRW(area : RWops*)

  RW_SEEK_SET = 0
  RW_SEEK_CUR = 1
  RW_SEEK_END = 2

  # SDL_RWseek(ctx, offset, whence)	(ctx)->seek(ctx, offset, whence)
  # SDL_RWtell(ctx)			(ctx)->seek(ctx, 0, RW_SEEK_CUR)
  # SDL_RWread(ctx, ptr, size, n)	(ctx)->read(ctx, ptr, size, n)
  # SDL_RWwrite(ctx, ptr, size, n)	(ctx)->write(ctx, ptr, size, n)
  # SDL_RWclose(ctx)		(ctx)->close(ctx)

  fun read_le16 = SDL_ReadLE16(src : RWops*);
  fun read_be16 = SDL_ReadBE16(src : RWops*);
  fun read_le32 = SDL_ReadLE32(src : RWops*);
  fun read_be32 = SDL_ReadBE32(src : RWops*);
  fun read_le64 = SDL_ReadLE64(src : RWops*);
  fun read_be64 = SDL_ReadBE64(src : RWops*);

  fun write_le16 = SDL_WriteLE16(dst : RWops*, Uint16 value : UInt16)
  fun write_be16 = SDL_WriteBE16(dst : RWops*, Uint16 value : UInt16)
  fun write_le32 = SDL_WriteLE32(dst : RWops*, Uint32 value : UInt32)
  fun write_be32 = SDL_WriteBE32(dst : RWops*, Uint32 value : UInt32)
  fun write_le64 = SDL_WriteLE64(dst : RWops*, Uint64 value : UInt64)
  fun write_be64 = SDL_WriteBE64(dst : RWops*, Uint64 value : UInt64)
end
