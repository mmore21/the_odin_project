require 'game'

describe Game do
  subject(:game) { Game.new }
  context "when initialized" do
    it "creates a new object of the Game class" do
      expect(game).to be_an_instance_of(Game)
    end
  end

end
