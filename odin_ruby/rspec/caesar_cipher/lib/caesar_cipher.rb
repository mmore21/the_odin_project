class CaesarCipher
  attr_accessor :cipher, :message, :initial_num
  def initialize(message = "", shift_num)
    @alphabet = ("a".."z").to_a
    @capitals = ("A".."Z").to_a
    @cipher = []
    @message = message
    @shift_num = shift_num
    @start_array = message.split('')
  end

  def cipher_message
    @start_array.each do |i|
      # checks if the given letter is in the (lowercase) alphabet and executes accordingly
      if @alphabet.include?(i)
        index_num = @alphabet.index(i)
        new_index = cipher_index(index_num)
        new_letter = @alphabet[new_index]
        @cipher << new_letter
      elsif @capitals.include?(i)
        index_num = @capitals.index(i)
        new_index = cipher_index(index_num)
        new_letter = @capitals[new_index]
        @cipher << new_letter
      else
        @cipher << i
      end
    end
    @cipher = @cipher.join('')
  end

  def cipher_index(index_num)
    i = index_num + @shift_num
    while i >= 26
      i -= 26
    end
    i
  end
end

message = CaesarCipher.new("Hello", 3)
puts message.cipher_message
