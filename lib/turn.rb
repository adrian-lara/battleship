class Turn

  attr_reader :shot

  def initialize(shot)
    @shot = shot
  end

  def result(board)
    if (board.two_ship_location.include?(@shot) ||
        board.three_ship_location.include?(@shot))
      "hit"
    else
      "miss"
    end
  end

end
