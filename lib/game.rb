require './lib/player'
require './lib/turn'
require './lib/coordinates'

class Game < Turn

  attr_reader :status, :players, :timer, :winner
  def initialize()
    @status = nil
    @players = [Player.new("User"), Player.new("Computer")]
    @timer = nil
    @winner = nil
  end

  def run
    main_phase
  end

#TODO delete later. For creating game only
  def assume_assign_ships_phase_occurred
    # @players[0].two_ship_location = ["A1", "A2"]
    # @players[0].three_ship_location = ["B1", "B2", "B3"]
    # @players[1].two_ship_location = ["C1", "C2"]
    # @players[1].three_ship_location = ["D1", "D2", "D3"]
    @players[1].three_ship_location = ["D3"]
  end

  def main_phase
    assume_assign_ships_phase_occurred
    create_user_progress_board
    player_index = 1 #1 = user turn ; 0 = computer turn

    while @winner.nil?
      opponent_index = player_index
      player_index = (player_index + 1) % 2
      current_player = @players[player_index]
      opponent = @players[opponent_index]

      execute_turn(current_player, opponent)
    end

    display_game_result
  end

  def create_user_progress_board
    players[0].progress_board.create_board
  end

  def display_game_result
    puts "\n#{@winner.type} wins!!\n"
    puts "\nIt took #{@winner.turn_history.count} turns!\n\n"
  end

end
