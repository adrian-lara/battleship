require './lib/board'

class Player

  attr_accessor :owner_board, :opponent_board

  def initialize()
    @owner_board = Board.new
    @opponent_board = Board.new
  end



end
