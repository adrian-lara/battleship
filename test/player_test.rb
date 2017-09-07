require 'minitest/autorun'
require 'minitest/emoji'

require './lib/player'

class PlayerTest < Minitest::Test

  def test_player_exists
    player_1 = Player.new("User")

    assert_instance_of Player, player_1
  end

  attr_reader :player
  def setup
    @player_1 = Player.new("User")
    @player_2 = Player.new("Computer")
  end

  def test_player_has_an_owner_board
    assert_instance_of Board, @player_1.owner_board
  end

  def test_player_has_an_progress_board
    assert_instance_of Board, @player_1.progress_board
  end

  def test_player_has_a_type
    assert_equal "User", @player_1.type
    assert_equal "Computer", @player_2.type
  end

  def test_player_has_a_turn_history_array_thats_empty_by_default
    assert_equal [], @player_1.turn_history
    assert_equal [], @player_2.turn_history
  end

  def test_player_is_createed_with_two_empty_arrays_for_player_ship_placement
    assert_equal [], @player_1.two_ship_location
    assert_equal [], @player_1.three_ship_location
  end

  def test_assign_ships_validates_and_assigns_both_randomly_placed_ships_for_computer_user
    @player_2.assign_ships

    refute_equal [], @player_2.two_ship_location
    refute_equal [], @player_2.three_ship_location
  end

end
