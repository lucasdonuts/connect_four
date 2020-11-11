require "./lib/board.rb"

describe Board do
  context "creating a new board" do
    board = Board.new
    describe "#initialize" do
      it "should create an empty array of size 7" do
        expect(board.board.size).to eq(7)
      end

      it "should contain 7 empty arrays of size 6" do
        expect(board.board.all?{|column| column.size == 6}).to eq true
      end
    end
  end

  context "checking validity of move" do
    board = Board.new
    board.board[0] = ["O", "X", "O", "X", "O", "X"]
    board.board[1] = [nil, nil, nil, "X", "O", "X"]

    describe "#column_not_full?" do
      it "should return true when column chosen is empty" do
        expect(board.column_not_full?(7)).to eq true
      end

      it "should return true when column chosen is only partially filled" do
        expect(board.column_not_full?(2)).to eq true
      end

      it "should return false when column chosen is full" do
        expect(board.column_not_full?(1)).to eq false
      end
    end

    describe "#valid_move?" do
      it "should return false when choice is out of bounds" do
        expect(board.valid_move?(8)).to eq false
      end

      it "should return true when choice is between 1 and 7" do
        expect(board.valid_move?(4)).to eq true
      end

      it "should return false when choice is in bounds but column is full" do
        expect(board.valid_move?(1)).to eq false
      end

      it "should return true when choice is valid and column is not full" do
        expect(board.valid_move?(2)).to eq true
      end
    end
  end

  context "dropping a piece into the board" do
    board = Board.new
    describe "#drop_piece" do
      it "should drop piece in the correct column" do
        board.drop_piece("X", 1)
        expect(board.board[0]).to eq([nil, nil, nil, nil, nil, "X"])
        board.drop_piece("O", 2)
        expect(board.board[1]).to eq([nil, nil, nil, nil, nil, "O"])
      end

      it "should drop piece on top of already placed pieces" do
        board.drop_piece("X", 1)
        board.drop_piece("O", 2)
        expect(board.board[0]).to eq([nil, nil, nil, nil, "X", "X"])
        expect(board.board[1]).to eq([nil, nil, nil, nil, "O", "O"])
      end
    end
  end

  context "checking for game over" do
    board = Board.new
    describe "#draw?" do
      it "should return false when board is not full" do
        expect(board.draw?).to eq false
      end

      it "should return true when board is full" do
        board.board.fill(["O", "O", "O", "O", "O", "O"])
        expect(board.draw?).to eq true
      end
    end

    describe "#four_in_a_row?" do
      it "should return true when there are four of the same pieces in a row" do
        board = Board.new
        board.drop_piece("O", 1)
        board.drop_piece("O", 2)
        board.drop_piece("O", 3)
        board.drop_piece("O", 4)
        expect(board.four_in_a_row?).to eq true
      end

      it "should return true when the four in a row are in a higher row" do
        board = Board.new
        board.board[2] = [nil, "O", nil, nil, nil, nil]
        board.board[3] = [nil, "O", nil, nil, nil, nil]
        board.board[4] = [nil, "O", nil, nil, nil, nil]
        board.board[5] = [nil, "O", nil, nil, nil, nil]
        expect(board.four_in_a_row?).to eq true
      end

      it "should return false when no player has four in a row" do
        board = Board.new
        expect(board.four_in_a_row?).to eq false
      end
    end

    describe "#four_in_a_column?" do
      it "should return false when there aren't four in a column" do
        expect(board.four_in_a_column?).to eq false
      end

      it "should return true when there are four in a row in the first column" do
        board.board[0] = [nil, nil, "O", "O", "O", "O"]
        expect(board.four_in_a_column?).to eq true
      end

      it "should return true when there are four in a row in any column" do
        board = Board.new
        board.board[4] = [nil, nil, "O", "O", "O", "O"]
        expect(board.four_in_a_column?).to eq true
      end
    end

    describe "#four_diagonal?" do
      it "should return false when there is no diagonal four in a row" do
        board = Board.new
        expect(board.four_diagonal?).to eq false
      end

      it "should return true when there are four in a row diagonally forward" do
        board = Board.new
        board.board[0][0] = "O"
        board.board[1][1] = "O"
        board.board[2][2] = "O"
        board.board[3][3] = "O"
        expect(board.four_diagonal?).to eq true
      end

      it "should return true when there are four in a row diagonally backward" do
        board = Board.new
        board.board[6][0] = "O"
        board.board[5][1] = "O"
        board.board[4][2] = "O"
        board.board[3][3] = "O"
        expect(board.four_diagonal?).to eq true
      end

      it "should return true when there are four in a row anywhere" do
        board = Board.new
        board.board[6][2] = "O"
        board.board[5][3] = "O"
        board.board[4][4] = "O"
        board.board[3][5] = "O"
        expect(board.four_diagonal?).to eq true
      end
    end

    describe "#win?" do
      it "should return false with no win" do
        board = Board.new
        expect(board.win?).to eq false
      end

      it "should return true with a vertical win" do
        board = Board.new
        board.board[0][0] = "O"
        board.board[0][1] = "O"
        board.board[0][2] = "O"
        board.board[0][3] = "O"
        expect(board.win?).to eq true
      end

      it "should return true with a horizontal win" do
        board = Board.new
        board.board[0][0] = "O"
        board.board[1][0] = "O"
        board.board[2][0] = "O"
        board.board[3][0] = "O"
        expect(board.win?).to eq true
      end

      it "should return true with a diagonal win" do
        board = Board.new
        board.board[0][0] = "O"
        board.board[1][1] = "O"
        board.board[2][2] = "O"
        board.board[3][3] = "O"
        expect(board.win?).to eq true
      end
    end
  end
end