class Space
  attr_accessor :piece

  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def to_s
    piece ? piece.to_s : "-"
  end
end