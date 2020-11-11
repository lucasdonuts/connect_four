require "./lib/player.rb"

describe Player do
  context "creating a new player" do
    player1 = Player.new("Player 1", "X")
    player2 = Player.new("Player 2", "O")

    it "should return 'Player 1' as the name of player1" do
      expect(player1.name).to eq("Player 1")
    end

    it "should return 'X' as player1's piece" do
      expect(player1.piece).to eq("X")
    end

    it "should return 'Player 2' as the name of player2" do
      expect(player2.name).to eq("Player 2")
    end

    it "should return 'O' as player2's piece" do
      expect(player2.piece).to eq("O")
    end
  end

  context "getting a player's move" do
    describe "#get_move" do
      
    end
  end
end