require 'pry'
require './lib/player'

class Battleship

  attr_reader :status, :players, :timer, :winner
  def initialize()
    @status = nil
    @players = [Player.new("user"), Player.new("computer")]
    @timer = nil
    @winner = nil
  end

end
