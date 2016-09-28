class Board
	attr_reader :spaces
	def initialize
		@spaces = []		
		build_board
	end

	def build_board
		board = []
		(0..7).each do |i|
			(0..7).each do |j|
				@spaces << [i, j]
			end
		end
	end
end

class Knight
	@@MOVES = [ [ 1,2], [ 1,-2],
							[-1,2], [-1,-2],
							[ 2,1], [ 2,-1],
							[-2,1], [-2,-1] ]
	attr_reader :path, :position

	def initialize(position, path = [])
		@position = position
		@path = path + [position]
		@board = Board.new
	end

	def possible_moves
		moves = []
		@@MOVES.each do |move|
			moves << [position,move].transpose.map {|x| x.reduce(:+)}
		end
		moves.select { |move| @board.spaces.include?(position) }
	end

end

def knight_moves(start, finish)
	queue = []
	knight = Knight.new(start)
	loop {
		break if knight.position == finish
		knight.possible_moves.each do |move|
			queue << Knight.new(move, knight.path)
		end
		knight = queue.shift
	}
	number_moves = knight.path.length
	puts "You made it in #{number_moves} moves!  Here's your path:"
	knight.path.each { |move| p move }
end

if __FILE__ == $0
	start = [0,0]
	finish = [3,5]
	knight_moves(start, finish)
end