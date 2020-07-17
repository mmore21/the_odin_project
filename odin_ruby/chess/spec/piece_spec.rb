require 'piece'
require 'stringio'
include Piece

describe Piece do

  describe "move" do
    before do
      $stdin = StringIO.new("A3")
    end
    after do
      $stdin = STDIN
    end

    it "Should be 'A3'" do
      expect(Piece::move).to be == "A3"
    end
  end
=begin
  describe Knight do
    # some code
  end

  describe Bishop do
    # some code
  end

  describe Rook do
    # some code
  end

  describe Queen do
    # some code
  end

  describe King do
    # some code
  end
=end
end
