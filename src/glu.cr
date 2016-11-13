require "./lib_glu"

module GLU
  def self.ortho2d(left, right, bottom, top)
    LibGLU.gluOrtho2D(left, right, bottom, top)
  end
end
