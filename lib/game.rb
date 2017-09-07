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
    start_time
    ship_placement_phase
    main_phase
    end_time
    display_game_result
  end

  def start_time
    @timer = Time.now
  end

  def end_time
    @timer = Time.now - @timer
  end

  def ship_placement_phase
    @players.each { |player| player.assign_ships }
  end

  def main_phase
    create_user_progress_board
    player_index = 1

    while @winner.nil?
      opponent_index = player_index
      player_index = (player_index + 1) % 2
      current_player = @players[player_index]
      opponent = @players[opponent_index]

      execute_turn(current_player, opponent)
    end
  end

  def create_user_progress_board
    players[0].progress_board.create_board
  end

  def display_game_result
    salutation = "Congratulations!"
    salutation = "Sorry!" if @winner.type == "Computer"

    puts "\n#{salutation}\nThe #{@winner.type.downcase} wins!!\n"
    puts "\nIt took #{@winner.turn_history.count} turns!\n\n"
    puts "Elapsed game time was #{convert_seconds(@timer)}."
  end

  def convert_seconds(time)
    minutes = (time/60).to_i
    seconds = (time % 60).to_i
    "#{minutes} minutes and #{seconds} seconds"
  end

end
