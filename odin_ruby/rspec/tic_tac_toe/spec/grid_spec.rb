require 'player'
require 'grid'

describe Grid do
  subject(:player) { Player.new }
  subject(:grid) { Grid.new(player) }

  it "initializes a new grid" do
    expect(grid).to be_an_instance_of(Grid)
    expect(grid.grid_array).to eql(["1","2","3","4","5","6","7","8","9"])
    expect(grid.boxes_left).to eql(9)
  end

  describe "#check_if_won" do
    context "when game is not won" do
      it "return true and do nothing" do
        expect(grid.check_if_won).to eql(true)
      end
    end

    context "when player  wins" do
      before { grid.grid_array = ["X", "X", "X", "O", "5", "6", "7", "8", "9"] }
      it "returns player win message and ends game" do
        expect(grid.check_if_won).to eql(false)
      end
    end

    context "when game is a scratch" do
      before { grid.boxes_left = 0 }
      it "returns scratch message and ends game" do
        expect(grid.check_if_won).to eql(false)
      end
    end

  end
end
