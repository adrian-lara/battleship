require 'pry'
require './lib/player'
require './lib/turn'

class Battleship

  attr_reader :status, :players, :timer, :winner
  def initialize()
    @status = nil
    @players = [Player.new("user"), Player.new("computer")]
    @timer = nil
    @winner = nil
  end

#TODO delete later
  def assume_assign_ships_phase

  end

  def main_phase
    create_opponent_boards
    player_index = 1

    while @winner.nil?
      opponent_index = player_index
      player_index = (player_index + 1) % 2
      current_player = @players[player_index]
      opponent = @players[opponent_index]

      result = take_shot(current_player, opponent)
      #if result == "hit", call hit_sequence method
      #if current_player.type == user, update_opponent_board method to change rendering of opponent_board
      # => and render opponent_board
      @winner == "user"
    end
  end

  def create_opponent_boards
    @players.each { |player| player.opponent_board.create_board }
  end

  def take_shot(current_player, opponent)
    if current_player.type == "user"
      shot_location = user_shot(current_player)
    else
      shot_location = computer_shot(current_player)
    end
    current_shot = Turn.new(shot_location)
    current_player.turn_history << current_shot
    current_shot.result(opponent.owner_board)
  end

#only logic that differs between computer and user is how location is attained
  def user_shot(current_player)
    shot_validity = false
    #TODO currently cannot exit loop
    until shot_validity
      location = gets.chomp

      coordinates = Coordinates.new(location)
      shot_validity = coordinates.valid?
    end
    location
  end

  def computer_shot(current_player)
    shot_validity = false
    until shot_validity
      random_row_number = rand(0..3)
      random_row = ["A", "B", "C", "D"][random_row_number]
      random_column = rand(1..4)
      location = random_row + random_column.to_s

      coordinates = Coordinates.new(location)
      shot_validity = coordinates.valid?
    end
    location
  end

end
