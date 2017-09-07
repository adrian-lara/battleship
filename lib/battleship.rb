require 'pry'
require './lib/player'
require './lib/turn'
require './lib/coordinates'

class Battleship

  attr_reader :status, :players, :timer, :winner
  def initialize()
    @status = nil
    @players = [Player.new("User"), Player.new("Computer")]
    @timer = nil
    @winner = nil
  end

#TODO delete later. For creating game only
  def assume_assign_ships_phase_occurred
    @players[0].two_ship_location = ["A1", "A2"]
    @players[0].three_ship_location = ["B1", "B2", "B3"]
    @players[1].two_ship_location = ["C1", "C2"]
    @players[1].three_ship_location = ["D1", "D2", "D3"]
  end

  def main_phase
    assume_assign_ships_phase_occurred
    create_opponent_boards
    player_index = 1 #1 = user turn ; 0 = computer turn

    while @winner.nil?
      opponent_index = player_index
      player_index = (player_index + 1) % 2
      current_player = @players[player_index]
      opponent = @players[opponent_index]
      display_turn_owner(current_player)

      current_player.opponent_board.print_board if current_player.type == "User"

      #shot_sequence
      current_turn = take_shot(current_player)
      shot_result = current_turn.result(opponent)
      display_shot_result(current_turn, shot_result)

      #hit_sequence
      if shot_result == "hit"
        turn_result = hit_sequence(current_turn.shot, opponent)
      end

      break @winner = current_player if turn_result == "Game Over"

      if current_player.type == "User"
        update_opponent_board(current_turn, shot_result)
      end
      #if , update_opponent_board method to change rendering of opponent_board
      # => and render opponent_board
    end

    display_game_result
  end

#might only need to create user opponent board
  def create_opponent_boards
    @players.each { |player| player.opponent_board.create_board }
  end

  def display_turn_owner(current_player)
    puts "\n===#{current_player.type}'s Turn!===\n"
  end

  def take_shot(current_player)
    if current_player.type == "User"
      shot_location = user_shot(current_player)
    else
      shot_location = computer_shot(current_player)
    end
    current_turn = Turn.new(shot_location)
    current_player.turn_history << current_turn

    current_turn
  end

  def display_shot_result(turn, shot_result)
    puts "The shot #{turn.shot} was a #{shot_result}!\n"
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

  def update_opponent_board(turn, result)
    #use shot location to find opponent_board working_rows
    coordinates = Coordinates.new(turn.shot)
    board = @players[0].opponent_board.working_rows
    board[coordinates.row_number][coordinates.column_number] = result[0].upcase
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

  def display_game_result
    puts "\n#{@winner.type} wins!!\n"
    puts "\nIt took #{@winner.turn_history.count} turns!\n\n"
  end

end
