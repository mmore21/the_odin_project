require 'player'

describe Player do
  subject(:player) { Player.new }
  context "when initialized" do
    it "creates a new object of the Player class" do
      expect(player).to be_an_instance_of(Player)
    end
  end

end
