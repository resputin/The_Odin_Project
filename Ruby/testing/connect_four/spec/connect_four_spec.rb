require "connect_four"

describe "board" do
  let(:board) { Board.new }

  context "initialize" do
    it "builds a 7 by 6 board of spaces" do
      expect(board.spaces).to eq([["-", "-", "-", "-", "-", "-"],
                                  ["-", "-", "-", "-", "-", "-"],
                                  ["-", "-", "-", "-", "-", "-"],
                                  ["-", "-", "-", "-", "-", "-"],
                                  ["-", "-", "-", "-", "-", "-"],
                                  ["-", "-", "-", "-", "-", "-"],
                                  ["-", "-", "-", "-", "-", "-"]])
    end
    it "draws the correct board" do
      expect(board.draw).to be true
    end
  end

  context "update" do
    before(:example) do
      board.update(1, 0, 0)
      board.update(1, 0, 2)
    end

    it "can play a piece on the bottom" do
      expect(board.spaces[0][0]). to eq(1)
    end

    it "can play a piece above another piece" do
      expect(board.update(1, 0, 1)). to be true
    end

    it "can't play a hovering piece" do
      expect(board.spaces[0][2]). to eq("-")
    end

    it "can't play on top of another piece" do
      expect(board.update(1, 0, 0)).to be false
    end
  end

  describe "victory?" do

    it "handles non victory" do
      expect(board.victory?(1)).to be false
    end

    context "handles out of bounds" do
      before(:example) do
        board.update(1, 4, 0)
        board.update(1, 5, 0)
        board.update(1, 6, 0)
        board.update(1, 0, 0)
        board.update(2, 4, 1)
        board.update(2, 5, 1)
        board.update(2, 6, 1)
        board.update(2, 0, 1)
      end
      it "handles non victory" do
        expect(board.victory?(1)).to be false
      end
    end

    context "vertical_victory?" do
      before(:example) do
        board.update(1, 0, 0)
        board.update(1, 0, 1)
        board.update(1, 0, 2)
        board.update(1, 0, 3)
        board.update(2, 1, 0)
        board.update(2, 1, 1)
        board.update(2, 1, 2)
        board.update(2, 1, 3)
      end
      it "has player 1 win" do 
        expect(board.victory?(1)).to be true
      end

      it "has player 2 win" do
        expect(board.victory?(2)).to be true
      end

    end

    context "horizontal_victory?" do
      before(:example) do
        board.update(1, 0, 0)
        board.update(1, 1, 0)
        board.update(1, 2, 0)
        board.update(1, 3, 0)
        board.update(2, 0, 1)
        board.update(2, 1, 1)
        board.update(2, 2, 1)
        board.update(2, 3, 1)
      end    

      it "has player 1 win" do
        expect(board.victory?(1)).to be true
      end

      it "has player 2 win" do
        expect(board.victory?(1)).to be true
      end
    end

    context "diagonal_victory?" do
      before(:example) do
        board.update(1, 0, 0)
        board.update(2, 1, 0)
        board.update(1, 1, 1)
        board.update(2, 2, 0)
        board.update(2, 2, 1)
        board.update(1, 2, 2)
        board.update(2, 3, 0)
        board.update(1, 3, 1)
        board.update(2, 3, 2)
        board.update(1, 3, 3)
        
        board.update(1, 4, 0)
        board.update(2, 4, 1)
        board.update(2, 5, 0)
        board.update(2, 5, 1)
        board.update(2, 5, 2)
        board.update(1, 6, 0)
        board.update(1, 6, 1)
        board.update(2, 6, 2)
        board.update(2, 6, 3)
      end 

      it "has player 1 win" do
        expect(board.victory?(1)).to be true
      end

      it "has player 2 win" do
        expect(board.victory?(2)).to be true
      end
    end
  end 

  describe "play" do

    context "with no piece in column" do
      before(:example) do
        board.play(1, 0)
      end
      it "plays piece on the bottom" do
        expect(board.spaces[0][0]). to eq(1)
      end
    end

    context "with a full column" do
      before(:example) do
        board.update(1, 0, 0)
        board.update(1, 0, 1)
        board.update(1, 0, 2)
        board.update(1, 0, 3)
        board.update(1, 0, 4)
        board.update(1, 0, 5)
      end

      it "doesn't let you play another piece" do
        expect(board.play(1, 0)).to be false
      end
    end

    context "with a piece in the row" do
      before(:example) do
        board.play(1, 0)
        board.play(1, 0)
      end
      it "plays another piece on top of the previous one" do 
        expect(board.spaces[0][1]). to eq(1)
      end
    end
  end

  describe "gameloop" do

    context "new_game" do
      before(:example) do
        board.new_game
      end
      it "starts with player 1" do
        expect(board.spaces[0][0]).to eq(1)
      end
    end
  end
end