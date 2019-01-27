module Messages
  def intro_message
    puts "Welcome to Tic-Tac-Toe"
    help_message
  end

  def help_message
    puts
    puts "To make your move, type the number corresponding to the box."
    puts "To restart the game, type 'restart'."
    puts "To exit the game, type 'exit'."
    puts "To view this help dialouge again, type 'help'."
    puts
  end

  def restart_message
    puts
    puts "Game has been reset."
    puts
  end

  def exit_message
    puts
    puts "Thanks for playing."
  end

  def invalid_message
    puts
    puts "Invalid command. Type 'help' for help."
    puts
  end
end
