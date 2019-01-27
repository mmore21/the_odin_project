require 'rspec'
require 'caesar_cipher'

describe CaesarCipher do
  describe "#cipher_message" do

    context "given a string with a shift of 1" do
      it "shifts the entire string 1" do
        expect(CaesarCipher.new("hello", 1).cipher_message).to eql("ifmmp")
      end
    end

    context "given an empty string" do
      it "returns the empty string" do
        expect(CaesarCipher.new("", 5).cipher_message).to eql("")
      end
    end

    context "given a shift of 0" do
      it "returns same string that was given" do
        expect(CaesarCipher.new("hello", 0).cipher_message).to eql("hello")
      end
    end

    context "given a string with special characters" do
      it "returns same characters given" do
        expect(CaesarCipher.new("#%^&", 5).cipher_message).to eql("#%^&")
      end
    end

    context "given a string xyz" do
      it "returns abc" do
        expect(CaesarCipher.new("xyz", 3).cipher_message).to eql("abc")
      end
    end

    context "given a string of numbers" do
      it "returns same numbers given" do
        expect(CaesarCipher.new("12345", 48).cipher_message).to eql("12345")
      end
    end
  end

end
