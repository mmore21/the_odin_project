module Input

  def get_game_mode
    puts "Enter 1 for singleplayer vs AI or 2 for two players."
    input = ""
    until input == "1" || input == "2"
      input = gets.chomp
    end
    input
  end

  def get_origin_input
    puts "Enter piece to move:"
    get_coordinate_input
  end

  def get_target_input
    puts "Enter where to move it to:"
    get_coordinate_input
  end

  def get_coordinate_input
    input = ""
    until validate_input(input)
      input = gets.chomp.downcase.split('')
      return input.join('') if input.join('') == "pause"
    end
    input_to_coordinate(input)
  end

  def validate_input(input)
    return false if input.length != 2
    return false if (input[0] =~ /[a-h]/) == nil
    return false if (input[1] =~ /[1-8]/) == nil
    true
  end

  def input_to_coordinate(input)
    coordinate = [nil, input[1].to_i]
    letters = ("a".."h").to_a
    coordinate[0] = letters.index(input[0]).to_i + 1
    coordinate
  end

  def get_promotion_piece_name
    puts "Pawn has been promoted."
    puts "Choose a piece to upgrade to: | 'knight' | 'rook' | 'bishop' | 'queen' |"
    input = ""
    until validate_promotion_piece_name(input) == true
      input = gets.chomp.downcase
    end
    input
  end

  def validate_promotion_piece_name(name)
    possible_names = ["knight", "rook", "bishop", "queen"]
    return true if possible_names.include?(name)
    false
  end

end
