class Board
  attr_reader :spaces
  def initialize
    @spaces = []    
    build_board
  end

  def build_board
    (0..7).each do |i|
      (0..7).each do |j|
        @spaces << [i, j, nil]
      end
    end
  end

  def new_game
    #create pawns
    (0..7).each do |x|
      @spaces[(x * 8) + 1 ][3] = Pawn.new(@spaces[(x+1) * 7][0..1], 1)
      @spaces[(x * 8) + 6 ][3] = Pawn.new(@spaces[(x+1) * 7][0..1], 2)
    end
    #create rooks
    @spaces[0][3] = Rook.new(@spaces[0][0..1], 1)
    @spaces[7][3] = Rook.new(@spaces[7][0..1], 2)
    @spaces[56][3] = Rook.new(@spaces[57][0..1], 1)
    @spaces[63][3] = Rook.new(@spaces[63][0..1], 2)

    #create knights
    @spaces[8][3] = Knight.new(@spaces[8][0..1], 1)
    @spaces[48][3] = Knight.new(@spaces[48][0..1], 1)
    @spaces[15][3] = Knight.new(@spaces[15][0..1], 2)
    @spaces[55][3] = Knight.new(@spaces[55][0..1], 2)

    #create bishops
    @spaces[16][3] = Bishop.new(@spaces[16][0..1], 1)
    @spaces[40][3] = Bishop.new(@spaces[40][0..1], 1)
    @spaces[23][3] = Bishop.new(@spaces[23][0..1], 2)
    @spaces[47][3] = Bishop.new(@spaces[47][0..1], 2)

    #create queens
    @spaces[24][3] = Queen.new(@spaces[24][0..1], 1)
    @spaces[31][3] = Queen.new(@spaces[31][0..1], 2)

    #create kings
    @spaces[32][3] = King.new(@spaces[32][0..1], 1)
    @spaces[39][3] = King.new(@spaces[39][0..1], 2)

  end

  #can't figure out ternary operator that evaluates p
  def draw
    print "\n   a  b  c  d  e  f  g  h\n 8"
    i = 1
    while i <= 8
      (1..8).each do |j|
        if @spaces[((8 * j) - i)][3].class == Pawn
          if @spaces[((8 * j) - i)][3].side_id == 1
            print " \u{2659} "
          else
            print " \u{265F} "
          end

        elsif @spaces[((8 * j) - i)][3].class == Rook
          if @spaces[((8 * j) - i)][3].side_id == 1
            print " \u{2656} "
          else
            print " \u{265C} "
          end

        elsif @spaces[((8 * j) - i)][3].class == Knight
          if @spaces[((8 * j) - i)][3].side_id == 1
            print " \u{2658} "
          else
            print " \u{265E} "
          end

        elsif @spaces[((8 * j) - i)][3].class == Bishop
          if @spaces[((8 * j) - i)][3].side_id == 1
            print " \u{2657} "
          else
            print " \u{265D} "
          end

        elsif @spaces[((8 * j) - i)][3].class == Queen
          if @spaces[((8 * j) - i)][3].side_id == 1
            print " \u{2655} "
          else
            print " \u{265B} "
          end

        elsif @spaces[((8 * j) - i)][3].class == King
          if @spaces[((8 * j) - i)][3].side_id == 1
            print " \u{2654} "
          else
            print " \u{265A} "
          end

        else
          print " - "
        end      
      end
      if i < 8
        print "#{9 - i} \n #{8 - i}" 
      else 
        print "#{9 - i} \n   a  b  c  d  e  f  g  h"
      end
      i += 1
    end
    true
  end

  def space_select(piece_location)
    temp_location = piece_location.split("")
    column = (temp_location[0].downcase.ord) - 97
    row = temp_location[1].to_i
    location = (column * 8) + (row - 1)
  end

  def piece_select(location)
    @spaces[space_select(location)][3]
  end

  def delete_piece(location)
    @spaces[space_select(location)][3] = nil
  end

  def move(starting_location, ending_location)
    old_piece = piece_select(starting_location)
    #p old_piece.possible_moves(@spaces)
    new_location = space_select(ending_location)
    @spaces[new_location][3] = old_piece
    #@spaces[new_location][3].position
    delete_piece(starting_location)
  end
end

class Piece
  attr_reader :position, :move_count, :side_id
  def initialize(position, side_id)
    @position = position
    @move_count = 0
    @side_id = side_id
  end

  def possible_moves(spaces)
    possible_moves = []
    @moves.each do |move|
      possible_moves << [@position,move].transpose.map {|x| x.reduce(:+)}
      p possible_moves
    end
    possible_moves.select { |move| spaces.include?(position) }
  end

end

class Pawn < Piece
  def initialize(position, side_id)
    super(position, side_id)
    if side_id == 1
      @moves = [ [1, 1],  [-1, 1], 
                 [0, 1],  [0, 2]  ]
    else
      @moves = [ [1, -1], [-1, -1],
                 [0, -1], [0, -2] ]
    end
  end
end

class Rook < Piece
  @moves = [ [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
             [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
             [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
             [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7]]
end 

class Knight < Piece
  @moves = [ [ 1,2], [ 1,-2],
             [-1,2], [-1,-2],
             [ 2,1], [ 2,-1],
             [-2,1], [-2,-1] ]
end

class Bishop < Piece
  @moves = [ [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
             [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7],
             [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
             [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]]
end

class Queen < Piece
  @moves = [ [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0], [7, 0],
             [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6], [0, 7],
             [-1, 0], [-2, 0], [-3, 0], [-4, 0], [-5, 0], [-6, 0], [-7, 0],
             [0, -1], [0, -2], [0, -3], [0, -4], [0, -5], [0, -6], [0, -7],
             [1, 1], [2, 2], [3, 3], [4, 4], [5, 5], [6, 6], [7, 7],
             [-1, 1], [-2, 2], [-3, 3], [-4, 4], [-5, 5], [-6, 6], [-7, 7],
             [1, -1], [2, -2], [3, -3], [4, -4], [5, -5], [6, -6], [7, -7],
             [-1, -1], [-2, -2], [-3, -3], [-4, -4], [-5, -5], [-6, -6], [-7, -7]]
end

class King < Piece
  @moves = [ [1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]
end