class Board
  attr_accessor :spaces
  def initialize
    @spaces = []    
    build_board
  end

  def build_board
    (0..63).each do |i|
      @spaces << i
    end
  end

  def new_game
    #create pawns
    (0..7).each do |x|
      @spaces[(x * 8) + 1 ] = Pawn.new(@spaces[(x * 8) + 1], 1)
      @spaces[(x * 8) + 6 ] = Pawn.new(@spaces[(x * 8) + 6 ], 2)
    end
    #create rooks
    @spaces[0] = Rook.new(@spaces[0], 1)
    @spaces[7] = Rook.new(@spaces[7], 2)
    @spaces[56] = Rook.new(@spaces[56], 1)
    @spaces[63] = Rook.new(@spaces[63], 2)

    #create knights
    @spaces[8] = Knight.new(@spaces[8], 1)
    @spaces[48] = Knight.new(@spaces[48], 1)
    @spaces[15] = Knight.new(@spaces[15], 2)
    @spaces[55] = Knight.new(@spaces[55], 2)

    #create bishops
    @spaces[16] = Bishop.new(@spaces[16], 1)
    @spaces[40] = Bishop.new(@spaces[40], 1)
    @spaces[23] = Bishop.new(@spaces[23], 2)
    @spaces[47] = Bishop.new(@spaces[47], 2)

    #create queens
    @spaces[24] = Queen.new(@spaces[24], 1)
    @spaces[31] = Queen.new(@spaces[31], 2)

    #create kings
    @spaces[32] = King.new(@spaces[32], 1)
    @spaces[39] = King.new(@spaces[39], 2)

  end

  #can't figure out ternary operator that evaluates p
  def draw
    print "\n   a  b  c  d  e  f  g  h\n 8"
    i = 1
    while i <= 8
      (1..8).each do |j|
        if @spaces[((8 * j) - i)].class == Pawn
          if @spaces[((8 * j) - i)].side_id == 1
            print " \u{2659} "
          else
            print " \u{265F} "
          end

        elsif @spaces[((8 * j) - i)].class == Rook
          if @spaces[((8 * j) - i)].side_id == 1
            print " \u{2656} "
          else
            print " \u{265C} "
          end

        elsif @spaces[((8 * j) - i)].class == Knight
          if @spaces[((8 * j) - i)].side_id == 1
            print " \u{2658} "
          else
            print " \u{265E} "
          end

        elsif @spaces[((8 * j) - i)].class == Bishop
          if @spaces[((8 * j) - i)].side_id == 1
            print " \u{2657} "
          else
            print " \u{265D} "
          end

        elsif @spaces[((8 * j) - i)].class == Queen
          if @spaces[((8 * j) - i)].side_id == 1
            print " \u{2655} "
          else
            print " \u{265B} "
          end

        elsif @spaces[((8 * j) - i)].class == King
          if @spaces[((8 * j) - i)].side_id == 1
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

  def gameloop
    puts "Welcome to Chess!"
    self.draw
    player_turn = 1   
    while !@checkmate
      puts "\nPlayer #{player_turn} it is your turn"
      current_move = true
      while current_move == true
        puts "Select your piece:"
        piece_location = gets.chomp
        if piece_select(piece_location).class == Fixnum
          puts "There is no piece on that square"
        elsif piece_select(piece_location).side_id == player_turn
          puts "Select your move:"
          move = gets.chomp
          if check?(player_turn)
            if out_of_check?(player_turn, piece_location, move)
              move(piece_location, move)
              current_move = false
              self.draw
            else
              puts "That does not take you out of check"
            end
          else
            if out_of_check?(player_turn, piece_location, move) 
              if move(piece_location, move)
                current_move = false
                self.draw
              else
                puts "That is an invalid move please try again:"
              end
            else
              puts "That move puts you in check"
            end
          end
        else
          puts "You must choose one of your own pieces"
        end
      end
      player_turn == 1 ? player_turn = 2 : player_turn = 1
      if check?(player_turn)
        puts "\nPlayer #{player_turn} is in check"
        if checkmate?(player_turn)
          puts "Player #{player_turn} loses!"
        end
      end
    end

  end

  def space_select(piece_location)
    if piece_location.class == String
      temp_location = piece_location.split("")
      column = (temp_location[0].downcase.ord) - 97
      row = temp_location[1].to_i
      location = (column * 8) + (row - 1)
    else
      piece_location
    end
  end

  def piece_select(location)
    @spaces[space_select(location)]
  end

  def delete_piece(location)
      @spaces[space_select(location)] = space_select(location)
  end

  def move(starting_location, ending_location)
    old_piece = piece_select(starting_location)
    new_location = space_select(ending_location)
    possible_moves = old_piece.possible_moves(@spaces)   
    if possible_moves.include?(new_location)     
      @spaces[new_location] = old_piece
      @spaces[new_location].position = new_location
      @spaces[new_location].move_count += 1
      delete_piece(starting_location)
      true
    else
      false
    end
  end

  def check?(side)
    king_location = 0
    (0..63).each do |space|
      if @spaces[space].class == King and @spaces[space].side_id == side
         king_location = space
      end      
    end
    return return_all_side_moves(side == 1 ? 2 : 1).include?(king_location)
  end

  def out_of_check?(side, starting_location, ending_location)
    old_piece = piece_select(starting_location)
    old_position = old_piece.position
    old_move_count = old_piece.move_count
    temp_captured_piece = nil
    if piece_select(ending_location).class != Fixnum
      temp_captured_piece = piece_select(ending_location)
      captured_position = temp_captured_piece.position
      captured_move = temp_captured_piece.move_count
    end
    self.move(starting_location, ending_location)
    if !self.check?(side)
      @spaces[space_select(starting_location)] = old_piece
      @spaces[space_select(starting_location)].position = old_position
      @spaces[space_select(starting_location)].move_count = old_move_count
      if temp_captured_piece != nil
        @spaces[space_select(ending_location)] = temp_captured_piece
        @spaces[space_select(ending_location)].position = captured_position
        @spaces[space_select(ending_location)].move_count = captured_move
      else
        @spaces[space_select(ending_location)] = space_select(ending_location)
      end
      return true
    else
      @spaces[space_select(starting_location)] = old_piece
      @spaces[space_select(starting_location)].position = old_position
      @spaces[space_select(starting_location)].move_count = old_move_count
      if temp_captured_piece != nil
        @spaces[space_select(ending_location)] = temp_captured_piece
        @spaces[space_select(ending_location)].position = captured_position
        @spaces[space_select(ending_location)].move_count = captured_move
      else
        @spaces[space_select(ending_location)] = space_select(ending_location)
      end
      return false
    end
  end

  def checkmate?(side) 
    @checkmate = true
    self.spaces.each do |space|
      if space.class != Fixnum
        if space.side_id == side
          space.possible_moves(self.spaces).each do |possible_move|
            if out_of_check?(side, space.position, possible_move)
              @checkmate = false
            end
          end
        end
      end
    end
    return @checkmate
  end

  def return_all_side_moves(side)
    all_side_moves = []
    (0..63).each do |space|
      if @spaces[space].class != Fixnum and @spaces[space].side_id == side
        all_side_moves << @spaces[space].class
        @spaces[space].possible_moves(@spaces).each { |x| all_side_moves << x } 
      end
    end
    all_side_moves
  end
end

class Piece
  attr_accessor :position, :move_count, :side_id
  def initialize(position, side_id)
    @position = position
    @move_count = 0
    @side_id = side_id
  end

  def possible_moves(spaces)
    possible_moves = []
    i = 0 
    prev_move = @position
    while i < @moves.length
      broken = false
      @moves[i].each do |move|
        #skip over remaining moves in same direction if there is a piece blocking or off edge
        unless broken
          new_move = @position + move
          if (0..63).include?(new_move)
            #if move is decrementing in each array then mod 8 break
            #if move is incrementing in each array then 1 - mod 8 breaks
            if (((prev_move + 1) % 8 == 0) and (new_move % 8 == 0)) or ((prev_move % 8 == 0) and ((new_move + 1) % 8 == 0))
              #possible_moves << new_move
              broken = true
            elsif spaces[new_move].class == Fixnum 
              possible_moves << new_move
              prev_move = new_move
            elsif spaces[new_move].side_id != @side_id
              possible_moves << new_move
              prev_move = new_move
              broken = true
            else
              broken = true
            end
          else
            broken = true
          end
        end
        
      end
      i += 1
    end
    possible_moves
  end



end

class Pawn < Piece
  def initialize(position, side_id)
    super(position, side_id)
    if side_id == 1
      @moves = [1, 9, -7, 2]
    else
      @moves = [-1, 7, -9, -2]
    end
  end

  def possible_moves(spaces)
    possible_moves = []
    if @move_count > 0
      @moves = @moves[0..2]
    end
    @moves.each_with_index do |move, ind|
      possible_move = (@position + move)
      if (0..63).include?(possible_move)
        if ind == 0 or ind == 3
          if spaces[possible_move].class == Fixnum
            possible_moves << possible_move
          end
        elsif spaces[possible_move].class == Fixnum
        else
          if spaces[possible_move].side_id != @side_id
            possible_moves << possible_move
          end
        end
      end
    end
    possible_moves
  end
end

class Rook < Piece
  def initialize(position, side_id)
    super(position, side_id)
    @moves = [[1,2,3,4,5,6,7],
              [-1,-2,-3,-4,-5,-6,-7],
              [8,16,24,32,40,48,56],
              [-8,-16,-24,-32,-40,-48,-56]]
    end
end 

class Knight < Piece
  def initialize(position, side_id)
    super
    @moves = [[-15,-6,10,17],[15,6,-10,-17]]
  end

  def possible_moves(spaces)
    possible_moves = []
    if ((@position + 1) % 8 == 0) or ((@position + 2) % 8 == 0)
      @moves = [15,6,-10,-17]
    elsif (@position % 8 == 0) or ((@position - 1) % 8 == 0)
      @moves = [-15,-6,10,17]
    end
    @moves.each do |move|
      possible_moves << (@position + move)
    end
    possible_moves.select! { |move| (0..63).include?(move) }
    possible_moves.select! do |move| 
      spaces[move].class == Fixnum or spaces[move].side_id != @side_id ? true : false
    end
    possible_moves
  end
end

class Bishop < Piece
  def initialize(position, side_id)
    super
    @moves = [[9,18,27,36,45,54,63],
              [-9,-18,-27,-36,-45,-54,-63],
              [7,14,21,28,35,42,49,56],
              [-7,-14,-21,-28,-35,-42,-49,-56]]
  end
end

class Queen < Piece
  def initialize(position, side_id)
    super(position, side_id)
    @moves = [[1,2,3,4,5,6,7],
              [-1,-2,-3,-4,-5,-6,-7],
              [8,16,24,32,40,48,56],
              [-8,-16,-24,-32,-40,-48,-56],
              [9,18,27,36,45,54,63],
              [-9,-18,-27,-36,-45,-54,-63],
              [7,14,21,28,35,42,49,56],
              [-7,-14,-21,-28,-35,-42,-49,-56]]
  end
end

class King < Piece
  def initialize(position, side_id)
    super(position, side_id)
    @moves = [1,9,8,7,-1,-9,-8,-7]
  end
  #same as knight possible moves additions
  def possible_moves(spaces)
    possible_moves = []
    if ((@position + 1) % 8 == 0)
      @moves = [8,7,-1,-9,-8]
    elsif (@position % 8 == 0)
      @moves = [-8,-7,1,9,8]
    end
    @moves.each do |move|
      possible_moves << (@position + move)
    end
    possible_moves.select! { |move| (0..63).include?(move) }
    possible_moves.select! do |move| 
      spaces[move].class == Fixnum or spaces[move].side_id != @side_id ? true : false
    end
    possible_moves
  end
end