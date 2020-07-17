require 'player'

describe Player do
  subject(:players) { Player.new }

  context "when initialized" do
    it "should create variables for two players and their symbols" do
      expect(players).to be_an_instance_of(Player)
      expect(players.player1).to eql("Player 1")
      expect(players.player2).to eql("Player 2")
      expect(players.player1_symbol).to eql("●")
      expect(players.player2_symbol).to eql("○")
    end
  end

  describe "#change_current_player" do
    context "when current player is player1" do
      before { players.change_current_player }

      it "changes current_player to player2" do
        expect(players.current_player).to eql(players.player2)
      end

      it "changes current_symbol to player2's symbol" do
        expect(players.current_symbol).to eql(players.player2_symbol)
      end

    end
  end
end
