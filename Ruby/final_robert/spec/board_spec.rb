require_relative '../lib/board'

RSpec.describe Board do
  describe '#initialize' do
    it 'initializes with 64 spaces on the board' do
      board = Board.new

      expect(board.board.length).to be(8)
    end
  end

  describe '#space_at' do
    subject(:board) { Board.new }

    it 'returns the space at the coordinates' do
      space = board.space_at(4, 5)

      expect(space.x).to eq(4)
      expect(space.y).to eq(5)
      expect(space.piece).to be_nil
    end
  end

  describe '#insert' do
    subject(:board) { Board.new }

    it 'changes the space to the piece given' do
      piece = double("FakePiece")
      board.insert(piece: piece, x: 0, y: 4)

      space = board.space_at(0, 4)

      expect(space.piece).to eq(piece)
    end
  end

  describe 'draw' do
    subject(:board) { Board.new }

    it ''
  end
end 