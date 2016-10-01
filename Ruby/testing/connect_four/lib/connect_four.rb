class Board
  attr_reader :spaces
  def initialize
    @spaces = []
    build_board
  end

  def build_board
    board = []
    (0..6).each do |i|
      @spaces << [i]
      @spaces[i].shift
      (0..5).each do |j|
        @spaces[i] << "-"
      end
    end
  end

  def draw
    i = 5
    while i >= 0
      (0..6).each do |j|
        if @spaces[j][i] == 1
          print "X "
        elsif @spaces[j][i] == 2
          print "O "
        else
          print @spaces[j][i].to_s + " "
        end
      end
      print "\n"
      i -= 1
    end
    print "1 2 3 4 5 6 7\n"
    true
  end

  def update(player_number, piece_column, piece_row)
    if @spaces[piece_column][piece_row] != "-"
      puts "You can't play a piece on top of another piece"
      false
    elsif piece_row == 0
      @spaces[piece_column][piece_row] = player_number
      true
      draw
    elsif @spaces[piece_column][piece_row - 1] != "-"
      @spaces[piece_column][piece_row] = player_number
      true
      draw
    else
      puts "You can't play a floating piece"
      false
    end
  end

  def victory?(player_number)
    (0..6).each do |i|
      (0..5).each do |j|
        if @spaces[i][j] == player_number
          if j < 3 and (1..3).all? { |x| @spaces[i][j + x] == player_number }
            return true
          elsif i < 4 and (1..3).all? { |x| @spaces[i + x][j] == player_number }
            return true
          elsif (i < 4 and j < 3) and (1..3).all? { |x| @spaces[i + x][j + x] == player_number }
            return true
          elsif (i < 4 and j > 2) and (1..3).all? { |x| @spaces[i + x][j - x] == player_number }
            return true
          end
        end
      end
    end
    false   
  end

  def play(player_number, piece_column)
    if @spaces[piece_column][5] != "-"
      return false
    elsif @spaces[piece_column][0] == "-"
      update(player_number, piece_column, 0)
      return true
    else
      i = 1
      while i < 6
        if @spaces[piece_column][i] == "-"
          update(player_number, piece_column, i)
          return true
        end
        i += 1
      end
    end
  end

  def new_game
    player_turn = 1
    turn_count = 0
    draw
    while !victory?(player_turn)
      puts "Where would you like to play your piece player #{player_turn}"
      column_play = gets.chomp.to_i - 1
      if play(player_turn, column_play)
        if victory?(player_turn)
          puts "You win!"
          break
        end
        player_turn == 1 ? player_turn = 2 : player_turn = 1
        turn_count += 1
      else
        puts "You can't play a piece there"
      end
      if turn_count == 42
        puts "It's a draw!"
        break
      end
    end
  end
end

#a = Board.new
#a.new_game
