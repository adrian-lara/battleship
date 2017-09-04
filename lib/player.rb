require './lib/board'

class Player

  attr_reader :board, :user_type

  def initialize
    @board = Board.new
    @user_type = "Human"
  end

end
