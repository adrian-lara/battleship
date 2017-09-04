require 'pry'
require './lib/player'

class Battleship

  attr_reader :status, :players, :timer, :winner
  def initialize()
    @status = nil
    @players = [player_1 = Player.new, player_2 = Player.new]
    @timer = nil
    @winner = nil
  end

end
