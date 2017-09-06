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

end
