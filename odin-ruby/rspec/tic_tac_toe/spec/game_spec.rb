require 'game'

describe Game do
  subject(:game) { Game.new }

  it "initializes a new game" do
    expect(game).to be_an_instance_of(Game)
    expect(game.playing).to eql(true)
  end

  describe "#restart_game" do
    before { game.restart_game }
    it "resets instance variables to initial" do
      expect(game.player.current_player).to eql("Player 1")
      expect(game.grid.boxes_left).to eql(9)
    end
  end
end
