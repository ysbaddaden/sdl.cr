module SDL
  class RWops
    @@rw_file = LibSDL.alloc_rw
    @@rw_file.value.type = LibSDL::RWOPS_UNKNOWN

    @@rw_file.value.size = ->(rwops : LibSDL::RWops*) {
      io = Box(File).unbox(rwops.value.hidden.unknown.data1)
      File.size(io.path).to_i64
    }

    @@rw_file.value.seek = ->(rwops : LibSDL::RWops*, offset : Int64, whence : LibC::Int) {
      wh = case whence
           when LibSDL::RW_SEEK_SET then IO::Seek::Set
           when LibSDL::RW_SEEK_CUR then IO::Seek::Current
           when LibSDL::RW_SEEK_END then IO::Seek::End
           else raise "can't seek: invalid whence value"
           end
      io = Box(File).unbox(rwops.value.hidden.unknown.data1)
      io.seek(offset.to_i32, wh)
      io.tell.to_i64
    }

    @@rw_file.value.read = ->(rwops : LibSDL::RWops*, ptr : Void*, size : LibC::SizeT, maxnum : LibC::SizeT) {
      io = Box(File).unbox(rwops.value.hidden.unknown.data1)
      slice = ptr.as(UInt8*).to_slice(maxnum * size)

      begin
        # FIXME: may have read incomplete objects (seek back)!
        count = 0
        while slice.size > 0
          count += read_bytes = io.read(slice)
          break if read_bytes == 0
          slice += read_bytes
        end
        LibC::SizeT.new(count / size)
      rescue ex
        LibC::SizeT.new(0)
      end
    }

    @@rw_file.value.write = ->(rwops : LibSDL::RWops*, ptr : Void*, size : LibC::SizeT, num : LibC::SizeT) {
      io = Box(File).unbox(rwops.value.hidden.unknown.data1)
      slice = ptr.as(UInt8*).to_slice(num * size)

      begin
        io.write(slice)
        num
      rescue ex
        LibC::SizeT.new(0)
      end
    }

    @@rw_file.value.close = ->(rwops : LibSDL::RWops*) {
      io = Box(File).unbox(rwops.value.hidden.unknown.data1)
      io.close unless io.closed?
      0
    }

    def self.open(path, mode = "rb")
      rwops = RWops.new(path, mode)
      begin
        yield rwops
      ensure
        rwops.close
      end
    end

    @io : File?
    @rw : LibSDL::RWops*
    @slice : Bytes?

    def initialize(path : String, mode = "rb")
      @io = File.open(path, "rb")
      @rw = @@rw_file.clone
      @rw.value.hidden.unknown.data1 = Box.box(@io)
    end

    def initialize(slice : Bytes, read_only = false)
      @slice = slice
      ptr = slice.to_unsafe.as(Void*)

      if read_only
        @rw = LibSDL.rw_from_const_mem(ptr, slice.bytesize)
      else
        @rw = LibSDL.rw_from_mem(ptr, slice.bytesize)
      end
    end

    def finalize
      close
      LibSDL.free_rw(@rw)
    end

    def close
      if io = @io
        io.close unless io.closed?
      end
    end

    def to_unsafe
      @rw
    end
  end
end
