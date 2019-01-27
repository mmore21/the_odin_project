require 'player'

describe Player do
  subject(:player) { Player.new }

  it "initalizes a new player" do
    expect(player).to be_an_instance_of(Player)
  end

  it "assigns the players names" do
    expect(player.player1).to eql("Player 1")
    expect(player.player2).to eql("Player 2")
  end

  it "assigns the symbols to each player" do
    expect(player.p1symbol).to eql("X")
    expect(player.p2symbol).to eql("O")
  end

  describe "#change_player" do
    context "when first player is player 1" do
      before { player.change_player }
      it "sets player 2 as current_player" do
        expect(player.current_player).to eql("Player 2")
      end
      it "sets O as current_symbol" do
        expect(player.current_symbol).to eql("O")
      end
    end
  end
end
