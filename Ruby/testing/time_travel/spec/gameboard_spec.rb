require "gameboard"
describe "gameboard" do
  describe "new_game" do
    context "generates new game" do
      before(:example) do
        @a = Gameboard.new
        @a.new_game
      end
      it "initializes array" do
        expect(@a.board_position).to eql (["empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty", "empty"])
      end
    end
  end
  describe "victory?" do
    context "player 1 victory" do
      before(:example) do
        @a = Gameboard.new
        @a.board_position = [1, 1, 1, 1, 1, 1, 1, 1, 1]
      end
      it "has player 1 win horizontally" do
        expect(@a.horizontal_victory?(1)).to be true
      end
      it "has player 1 win vertically" do
        expect(@a.vertical_victory?(1)).to be true
      end
      it "has player 1 win diagonally" do
        expect(@a.diagonal_victory?(1)).to be true
      end
    end
    context "player 2 victory" do
      before(:example) do
          @a = Gameboard.new
          @a.board_position = [2, 2, 2, 2, 2, 2, 2, 2, 2]
        end
      it "has player 2 win horizontally" do
        expect(@a.horizontal_victory?(2)).to be true
      end
      it "has player 2 win vertically" do
        expect(@a.vertical_victory?(2)).to be true
      end
      it "has player 2 win diagonally" do
        expect(@a.diagonal_victory?(2)).to be true
      end
    end
  end
end