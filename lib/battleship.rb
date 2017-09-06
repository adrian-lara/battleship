require 'pry'
require './lib/player'
require './lib/turn'
require './lib/coordinates'

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
    player_index = 1 #1 = user turn ; 0 = computer turn

# #TODO!!!!! currently cannot exit loop
#     while @winner != nil
      opponent_index = player_index
      player_index = (player_index + 1) % 2
      current_player = @players[player_index]
      opponent = @players[opponent_index]

      result = take_shot(current_player, opponent)
      #if result == "hit", call hit_sequence method
      #if current_player.type == user, update_opponent_board method to change rendering of opponent_board
      # => and render opponent_board
# @winner == "user"
# end
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

  def user_shot(current_player)
    shot_validity = false

    until shot_validity
      puts "\nEnter a valid shot location: "
      location = gets.chomp.upcase
      shot_validity = Coordinates.new(location).valid?
    end
    location
  end

  def computer_shot(current_player)
    shot_validity = false
    until shot_validity
#TODO this can be split out into its own method
      random_row_number = rand(0..3)
      random_row = ["A", "B", "C", "D"][random_row_number]
      random_column = rand(1..4)
      location = random_row + random_column.to_s

#TODO prove to yourself that this works
      history_check = current_player.turn_history.find { |turn| turn.shot == location }
      next unless history_check.nil?

      shot_validity = Coordinates.new(location).valid?
    end
    location
  end

end
