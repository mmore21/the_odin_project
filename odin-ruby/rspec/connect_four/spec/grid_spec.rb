require "grid"

describe Grid do
  subject(:grid) { Grid.new}

  context "when initialized" do
    it "should create a new instance of the class" do
      expect(grid).to be_an_instance_of(Grid)
    end
  end

  describe "#create" do
    before { grid.create }

    context "when called" do
      it "returns grid of size 42" do
        expect(grid.grid_array.size).to eql(42)
      end
    end
  end


end
