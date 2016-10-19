require_relative './space'

class Board
  attr_reader :board

  def initialize
    build_board
  end

  def space_at(x, y)
    board[x][y]
  end

  def insert(piece: nil, x: nil, y: nil)
    space = space_at(x, y)
    space.piece = piece
  end

  def draw
    drawn = []
    board.each do |row|
      drow = []

      row.each do |space|
        drow << space.to_s
      end

      drawn << drow.join(" ")
    end

    drawn.join("\n")
  end

  private

  def build_board
    @board = (0..7).each_with_object([]) do |x, b|
      b << (0..7).each_with_object([]) do |y, row|
        row << Space.new(x, y)
      end
    end
  end
end
