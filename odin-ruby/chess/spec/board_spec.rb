require 'board'

describe Board do
  subject(:board) { Board.new }

  context "when initialized" do
    it "creates a new object of the Board class" do
      expect(board).to be_an_instance_of(Board)
    end

    it "creates an empty array to store the cells" do
      expect(board.cells).to be_eql([])
    end
  end

  describe "#create" do
    before do
      board.create
    end

    it "creates a new array of the board" do
      expect(board.cells.length).to be_eql(64)
    end
  end

  describe "#show" do
    before do
      board.show
    end
    it "outputs a ascii-art board" do
      # expect(board.show).to eql
    end
  end
end
