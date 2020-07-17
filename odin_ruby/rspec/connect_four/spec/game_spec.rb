require 'game'

describe Game do
  subject(:game) { Game.new }
  context "when initialized" do
    it "creates a new object of the Game class" do
      expect(game).to be_an_instance_of(Game)
    end

    it "creates a players object and grid object" do
      expect(game.players).to be_an_instance_of(Player)
      expect(game.grid).to be_an_instance_of(Grid)
    end
    
  end
end
