require 'enumerable_methods'

describe Enumerable do

  # add more enumerable methods rspec tests later

  describe "my_count" do

    context "when on an empty array" do
      let(:array) { [] }
      it "returns 0" do
        expect(array.my_count).to eql(0)
      end
    end

    context "when on an array with 3 objects" do
      let(:array) { [1,2,3] }
      it "returns 3" do
        expect(array.my_count).to eql(3)
      end
    end

    context "when there is a range" do
      let(:range) { (0..3) }
      it "returns 4" do
        expect(range.my_count).to eql(4)
      end
    end

    context "when there is an invalid object (not enumerable)" do
      let(:array) { 50 }
      it "returns error" do
        expect{ array.my_count }.to raise_error(NoMethodError)
      end
    end
  end
end
