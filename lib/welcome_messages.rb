module WelcomeMessages

  def self.prompt_begin
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n>"
  end

  def self.print_instructions
    puts "Battleship is a guessing game for two players.\n" +
      "Each player has a board presented as a grid.\n" +
      "Each player places a fleet of two ships on his or her board.\n" +
      "The locations of the fleet are concealed from the other player.\n" +
      "Players alternate turns by calling shot locations at the other player's ships,\n" +
      "and the objective of the game is to destroy the opposing player's fleet.\n\n"
  end

  def self.print_start
    border = "------------------------------------\n" * 3
    puts border + "------------Game Start!!------------\n" + border
  end

end
