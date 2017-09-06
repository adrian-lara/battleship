require 'minitest/autorun'
require 'minitest/emoji'

require './lib/player'

class PlayerTest < Minitest::Test

  def test_player_exists
    player_1 = Player.new("user")

    assert_instance_of Player, player_1
  end

  attr_reader :player
  def setup
    @player_1 = Player.new("user")
    @player_2 = Player.new("computer")
  end

  def test_player_has_an_owner_board
    assert_instance_of Board, @player_1.owner_board
  end

  def test_player_has_an_opponent_board
    assert_instance_of Board, @player_1.opponent_board
  end

  def test_player_has_a_type
    assert_equal "user", @player_1.type
    assert_equal "computer", @player_2.type
  end

  def test_assign_ships_validates_and_assigns_both_randomly_placed_ships_for_computer_user
    @player_2.assign_ships

    refute_equal [], @player_2.owner_board.two_ship_location
    p @player_2.owner_board.two_ship_location
    refute_equal [], @player_2.owner_board.three_ship_location
    p @player_2.owner_board.three_ship_location
  end

  def test_assign_ships_prompts_for_and_performs_validation_and_assigns_both_ships
    @player_1.assign_ships

    refute_equal [], @player_1.owner_board.two_ship_location
    p @player_1.owner_board.two_ship_location
    refute_equal [], @player_1.owner_board.three_ship_location
    p @player_1.owner_board.three_ship_location
  end


  # def test_assign_ships_populates_working_rows_of_owner_board
  #   @player.assign_ships
  #   refute_equal [], @player.owner_board.working_rows
  # end
  #
  # def test_player_has_a_default_user_type_of_human
  #   assert_equal 'human', @player.user_type
  # end
  #
  # def test_assign_ships_calls_methods_to_assign_ships_without_error
  #   skip
  #   @player.assign_ships
  # end
  #
  # def test_ship_assignment_prompt_prints_without_errors
  #   @player.assignment_prompt
  # end
  #
  # def test_assign_two_unit_ship_takes_prompt_from_user_and_holds_them_on_board
  #   @player.assign_two_ship_location
  #
  #   assert_equal 2, @player.owner_board.two_ship_location.count
  # end

end
