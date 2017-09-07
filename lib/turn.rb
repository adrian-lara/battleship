class Turn

  attr_reader :shot

  def initialize(shot)
    @shot = shot
  end

  def execute_turn(current_player, opponent)
    display_turn_owner(current_player)
    display_progress_board if current_player.type == "User"

    current_turn = take_shot(current_player)
    shot_result = current_turn.result(opponent)
    display_shot_result(current_turn, shot_result)

    if shot_result == "hit"
      turn_result = hit_sequence(current_turn.shot, opponent)
    end

    return @winner = current_player if turn_result == "Game Ends"

    if current_player.type == "User"
      update_progress_board(current_turn, shot_result)
    end
  end

  def display_turn_owner(player)
    puts "\n===#{player.type}'s Turn!===\n"
  end

  def display_progress_board
    players[0].progress_board.print_board
  end

  def take_shot(player)
    if player.type == "User"
      shot_location = user_shot
    else
      shot_location = computer_shot(player)
    end
    current_turn = Turn.new(shot_location)
    player.turn_history << current_turn

    current_turn
  end

  def result(player)
    if (player.two_ship_location.include?(@shot) ||
        player.three_ship_location.include?(@shot))
      "hit"
    else
      "miss"
    end
  end

  def display_shot_result(turn, shot_result)
    puts "The shot #{turn.shot} was a #{shot_result}!\n"
  end

  def user_shot
    shot_validity = false

    until shot_validity
      puts "\nEnter a valid shot location: "
      location = gets.chomp.upcase
      shot_validity = Coordinates.new(location).valid?
    end
    location
  end

  def update_progress_board(turn, result)
    coordinates = Coordinates.new(turn.shot)
    board = @players[0].progress_board.working_rows
    board[coordinates.row_number][coordinates.column_number] = result[0].upcase
  end

  def computer_shot(computer)
    shot_validity = false
    until shot_validity
      location = random_location
      history_check = computer.turn_history.find { |turn| turn.shot == location }
      next unless history_check.nil?

      shot_validity = Coordinates.new(location).valid?
    end
    location
  end

  def random_location
    random_row_number = rand(0..3)
    random_row = ["A", "B", "C", "D"][random_row_number]
    random_column = rand(1..4)
    random_row + random_column.to_s
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
      return "Game Ends"
    end
  end

end
