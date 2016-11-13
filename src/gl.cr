require "./lib_gl"

module GL
  enum BufferBit
    COLOR   = LibGL::GL_COLOR_BUFFER_BIT
    DEPTH   = LibGL::GL_DEPTH_BUFFER_BIT
    ACCUM   = LibGL::GL_ACCUM_BUFFER_BIT
    STENCIL = LibGL::GL_STENCIL_BUFFER_BIT
  end

  enum Mode
    POINTS         = LibGL::GL_POINTS
    LINES          = LibGL::GL_LINES
    LINE_STRIP     = LibGL::GL_LINE_STRIP
    LINE_LOOP      = LibGL::GL_LINE_LOOP
    TRIANGLES      = LibGL::GL_TRIANGLES
    TRIANGLE_STRIP = LibGL::GL_TRIANGLE_STRIP
    TRIANGLE_FAN   = LibGL::GL_TRIANGLE_FAN
    QUADS          = LibGL::GL_QUADS
    QUAD_STRIP     = LibGL::GL_QUAD_STRIP
    POLYGON        = LibGL::GL_POLYGON
  end

  enum Matrix
    PROJECTION = LibGL::GL_PROJECTION
    MODELVIEW  = LibGL::GL_MODELVIEW
    TEXTURE    = LibGL::GL_TEXTURE
  end

  def self.clear(mask)
    LibGL.glClear(mask)
  end

  def self.begin(mode : Mode)
    LibGL.glBegin(mode)
    yield
    LibGL.glEnd
  end

  def self.flush
    LibGL.glFlush
  end


  def self.color(r : Int32, g : Int32, b : Int32)
    LibGL.glColor3ub(r, g, b)
  end

  def self.color(r : Float32, g : Float32, b : Float32)
    LibGL.glColor3f(r, g, b)
  end

  def self.color(r : Float64, g : Float64, b : Float64)
    LibGL.glColor3d(r, g, b)
  end

  def self.color(r : Int32, g : Int32, b : Int32, a : Int32)
    LibGL.glColor4ub(r, g, b)
  end

  def self.color(r : Float32, g : Float32, b : Float32, a : Float32)
    LibGL.glColor4f(r, g, b)
  end

  def self.color(r : Float64, g : Float64, b : Float64, a : Float64)
    LibGL.glColor4d(r, g, b)
  end


  def self.vertex(x : Int32, y : Int32)
    LibGL.glVertex2i(x, y)
  end

  def self.vertex(x : Float32, y : Float32)
    LibGL.glVertex2f(x, y)
  end

  def self.vertex(x, y)
    LibGL.glVertex2d(x.to_f64, y.to_f64)
  end

  def self.vertex(x : Int32, y : Int32, z : Int32)
    LibGL.glVertex3i(x, y, z)
  end

  def self.vertex(x : Float32, y : Float32, z : Float32)
    LibGL.glVertex3f(x, y, z)
  end

  def self.vertex(x, y, z)
    LibGL.glVertex3d(x.to_f64, y.to_f64, z.to_f64)
  end


  #def self.point_size(size)
  #  LibGL.glPointSize(size)
  #end

  #def self.line_width(width)
  #  LibGL.glLineWidth(width)
  #end


  def self.matrix(mode : Matrix, reset = true)
    LibGL.glMatrixMode(mode)
    LibGL.glLoadIdentity() if reset
  end

  def self.matrix(mode : Matrix, reset = true)
    matrix(mode, reset) if mode

    LibGL.glPushMatrix()
    begin
      yield
    ensure
      LibGL.glPopMatrix()
    end
  end

  def self.rotate(angle, x = 0.0, y = 0.0, z = 0.0)
    LibGL.glRotated(angle.to_f64, x.to_f64, y.to_f64, z.to_f64)
  end

  def self.translate(x, y, z = 0.0)
    LibGL.glTranslated(x.to_f64, y.to_f64, z.to_f64)
  end

  def self.scale(x, y, z = 1.0)
    LibGL.glScaled(x, y, z);
  end


  def self.draw_axis(size = 1)
    matrix do
      LibGL.glScalef(size, size, size)

      self.begin(Mode::LINES) do
        color(0, 0, 255)
        vertex(0, 0)
        vertex(1, 0)

        color(0, 255, 0)
        vertex(0, 0)
        vertex(0, 1)
      end
    end
  end
end
