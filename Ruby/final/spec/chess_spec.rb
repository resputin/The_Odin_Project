require "chess_single_array"

describe "chess" do
  let (:board) {Board.new}
  describe "board" do
    context "new_game" do
      before(:example) do
        board.new_game
      end
      it "initializes empty board" do
        expect(board.spaces).not_to eq(nil)
      end
      it "places white pawns" do
        expect(board.spaces[1].class).to eq(Pawn)
        expect(board.spaces[9].class).to eq(Pawn)
        expect(board.spaces[17].class).to eq(Pawn)
        expect(board.spaces[25].class).to eq(Pawn)
        expect(board.spaces[33].class).to eq(Pawn)
        expect(board.spaces[41].class).to eq(Pawn)
        expect(board.spaces[49].class).to eq(Pawn)
        expect(board.spaces[57].class).to eq(Pawn)
      end
      it "places black pawns" do
        expect(board.spaces[6].class).to eq(Pawn)
        expect(board.spaces[14].class).to eq(Pawn)
        expect(board.spaces[22].class).to eq(Pawn)
        expect(board.spaces[30].class).to eq(Pawn)
        expect(board.spaces[38].class).to eq(Pawn)
        expect(board.spaces[46].class).to eq(Pawn)
        expect(board.spaces[54].class).to eq(Pawn)
        expect(board.spaces[62].class).to eq(Pawn)
      end
      it "places white rooks" do
        expect(board.spaces[0].class).to eq(Rook)  
        expect(board.spaces[0].side_id).to eq(1)
        expect(board.spaces[56].class).to eq(Rook)
        expect(board.spaces[56].side_id).to eq(1)
      end
      it "places black rooks" do  
        expect(board.spaces[7].class).to eq(Rook)
        expect(board.spaces[7].side_id).to eq(2)
        expect(board.spaces[63].class).to eq(Rook)
        expect(board.spaces[63].side_id).to eq(2)
      end

      it "places white knights" do
        expect(board.spaces[8].class).to eq(Knight)
        expect(board.spaces[48].class).to eq(Knight)
        expect(board.spaces[8].side_id).to eq(1)
        expect(board.spaces[48].side_id).to eq(1)
      end
      it "places black knights" do
        expect(board.spaces[15].class).to eq(Knight)
        expect(board.spaces[55].class).to eq(Knight)
        expect(board.spaces[15].side_id).to eq(2)
        expect(board.spaces[55].side_id).to eq(2)
      end

      it "places white bishops" do
        expect(board.spaces[16].class).to eq(Bishop)
        expect(board.spaces[40].class).to eq(Bishop)
        expect(board.spaces[16].side_id).to eq(1)
        expect(board.spaces[40].side_id).to eq(1)
      end
      it "places black bishops" do
        expect(board.spaces[23].class).to eq(Bishop)
        expect(board.spaces[47].class).to eq(Bishop)
        expect(board.spaces[23].side_id).to eq(2)
        expect(board.spaces[47].side_id).to eq(2)
      end

      it "places white queen" do
        expect(board.spaces[24].class).to eq(Queen)
        expect(board.spaces[24].side_id).to eq(1)
      end
      it "places black queen" do
        expect(board.spaces[31].class).to eq(Queen)
        expect(board.spaces[31].side_id).to eq(2)
      end

      it "places white King" do
        expect(board.spaces[32].class).to eq(King)
        expect(board.spaces[32].side_id).to eq(1)
      end
      it "places black King" do
        expect(board.spaces[39].class).to eq(King)
        expect(board.spaces[39].side_id).to eq(2)
      end
    end

    context "draw" do
      before(:example) do
        board.new_game
      end
      it "draws" do
        expect(board.draw).to be true
      end
    end
  end

  describe "play" do
    let(:board) {Board.new}
    context "piece select" do
      before(:example) do
        board.new_game
      end
      it "selects the correct piece" do
        expect(board.piece_select("a1").class).to eq(Rook)
      end
    end
    context "pawn move" do
      before(:example) do
        board.new_game
        board.move("a2", "a3")
        board.move("d2", "g3")
        board.move("g2", "g4")
        board.move("h7", "h5")
        board.move("g4", "h5")
        board.move("d2", "d3")
        board.move("d3", "d5")
        board.move("d7", "e6")
      end
      it "moves the piece without checking for possible move" do
        expect(board.spaces[2].class).to eq(Pawn)
        expect(board.spaces[1]).to eq(1)
      end
      it "doesn't move a piece with incorrect movement" do
        expect(board.spaces[18]).to eq(18)
      end
      it "lets pawns capture" do
        expect(board.spaces[60].side_id).to eq(1)
      end
      it "2 square pawn move" do
        expect(board.spaces[26].class).to eq(Pawn)
      end
      it "only lets move diagonal on capture" do
        expect(board.spaces[30].class).to eq(Pawn)
      end
    end

    context "rook move" do
      before(:example) do
        board.new_game
      end
      it "lets rook move horizontally and vertically" do
        board.move("a2", "a4")
        board.move("a1", "a3")
        board.move("a3", "h3")
        board.move("h3", "h6")
        expect(board.spaces[61].class).to eq(Rook)
      end
      it "doesn't let rook pass another piece" do
        board.move("a1", "a3")
        expect(board.spaces[2]).to eq(2)
      end
      it "doesn't let rook capture same team" do
        board.move("a1", "a2")
        expect(board.spaces[1].class).to eq(Pawn)
      end
    end

    context "knight move" do
      before(:example) do
        board.new_game
      end
      it "lets knight jump over pieces" do
        board.move("b1", "c3")
        expect(board.spaces[18].class).to eq(Knight)
      end
      it "lets knight capture other pieces" do
        board.move("b7", "b5")
        board.move("b1", "c3")
        board.move("c3", "b5")
        expect(board.spaces[12].class).to eq(Knight)
      end
      it "doesn't let knight capture same team" do
        board.move("b1", "d2")
        expect(board.spaces[25].class).to eq(Pawn)
      end
    end

    context "bishop move" do
      before(:example) do
        board.new_game
      end
      it "lets Bishop move diagonally" do
        board.move("b2", "b3")
        board.move("c1", "a3")
        board.move("a3", "c5")
        expect(board.spaces[20].class).to eq(Bishop)
      end
      it "doesn't let Bishop pass another piece" do
        board.move("c1", "a3")
        expect(board.spaces[3]).to eq(3)
      end

      it "lets bishop capture another piece" do
        board.move("b2", "b3")
        board.move("c1", "a3")
        board.move("a3", "e7")
        expect(board.spaces[38].class).to eq(Bishop)
      end
      it "doesn't let bishop capture same team" do
        board.move("c1", "d2")
        expect(board.spaces[25].class).to eq(Pawn)
      end
    end

    context "Queen move" do
      before(:example) do
        board.new_game
      end
      it "lets Queen move diagonally" do
        board.move("c2", "c3")
        board.move("d1", "b3")
        board.move("b3", "d5")
        expect(board.spaces[28].class).to eq(Queen)
      end
      it "lets Queen move horizontally and vertically" do
        board.move("d2", "d4")
        board.move("d1", "d3")
        board.move("d3", "h3")
        board.move("h3", "h6")
        expect(board.spaces[61].class).to eq(Queen)
      end
      it "doesn't let Queen pass another piece" do
        board.move("c1", "a3")
        expect(board.spaces[3]).to eq(3)
      end

      it "lets Queen capture another piece" do
        board.move("c2", "c3")
        board.move("d1", "b3")
        board.move("b3", "f7")
        expect(board.spaces[46].class).to eq(Queen)
      end
      it "doesn't let queen capture same team" do
        board.move("d1", "d2")
        expect(board.spaces[25].class).to eq(Pawn)
      end
    end

    context "king move" do
      before(:example) do
        board.new_game
      end
      it "lets King capture other pieces" do
        board.move("c7", "c6")
        board.move("d8", "c7")
        board.move("c7", "e5")
        board.move("e5", "e2")
        board.move("e1", "e2")
      end
      it "doesn't let King capture same team" do
        board.move("e1", "d2")
        expect(board.spaces[25].class).to eq(Pawn)
      end
    end
  end
end