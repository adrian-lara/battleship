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
    while @winner.nil?
      opponent_index = player_index
      player_index = (player_index + 1) % 2
      current_player = @players[player_index]
      opponent = @players[opponent_index]

      hit_or_miss = take_shot(current_player, opponent)

      if hit_or_miss == "hit"
        current_shot = current_player.turn_history.last.shot
        result = hit_sequence(current_shot, opponent)
      end

      break @winner = current_player.type if result == "Game Over"

      #if current_player.type == user, update_opponent_board method to change rendering of opponent_board
      # => and render opponent_board
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
    current_shot.result(opponent)
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

  def hit_sequence(shot, opponent)
    ship_destroyed = remove_ship_coordinate(shot, opponent)
    check_all_ships_destroyed(opponent) if ship_destroyed
  end

  def remove_ship_coordinate(coordinate, opponent)
    if opponent.two_ship_location.include?(coordinate)
      opponent.two_ship_location.delete(coordinate)
      check_ship_status(opponent.two_ship_location)
    else
      opponent.three_ship_location.delete(coordinate)
      check_ship_status(opponent.two_ship_location)
    end
  end

  def check_ship_status(ship)
    true if ship.empty?
  end

  def check_all_ships_destroyed(player)
    if (player.two_ship_location.empty? &&
        player.three_ship_location.empty?)
      return "Game Over"
    end
  end

end
