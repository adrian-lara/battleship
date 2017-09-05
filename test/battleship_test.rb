require 'minitest/autorun'
require 'minitest/emoji'

require './lib/battleship'


class BattleshipTest < Minitest::Test

  # def test_the_file_starts_with_prompt
  #   skip
  #   File.open('./lib/battleship', "r")
  # end

  attr_reader :battleship
  def setup
    @battleship = Battleship.new
  end

  def test_battleship_game_can_be_created
    assert_instance_of Battleship, @battleship
  end

  def test_battleship_starts_with_nil_game_status
    assert_nil @battleship.status
  end

  def test_battleship_starts_with_array_of_two_players
    assert_instance_of Player, @battleship.players[0]
    assert_instance_of Player, @battleship.players[1]
  end

  def test_battleship_starts_with_nil_timer
    assert_nil @battleship.timer
  end

  def test_battleship_starts_with_nil_winner
    assert_nil @battleship.winner
  end

  def test_assign_user_ships_populates_working_rows_array_for_owner_board
    @battleship.assign_user_ships
    refute_equal [], @battleship.players[0].owner_board.working_rows
  end

  def test_assign_user_ships_assigns_both_ships_and_performs_validation_for_each
    @battleship.assign_user_ships

    refute_equal [], @battleship.players[0].owner_board.two_ship_location
    refute_equal [], @battleship.players[0].owner_board.three_ship_location
  end

  def test_assign_ship_location_prompts_user_for_two_positions_and_inputs_that_for_two_ship_into_location
    skip
    @battleship.assign_ship_location("two-unit")

    refute_equal [], @battleship.players[0].owner_board.two_ship_location
    assert_equal ["A1", "B1"], @battleship.players[0].owner_board.two_ship_location
  end

  def test_assign_ship_location_can_validate_and_assign_three_unit_ship_location_making_array_nonempty
    skip
    @battleship.assign_ship_location("three-unit", ["B2","B3"])

    refute_equal [], @battleship.players[0].owner_board.three_ship_location
  end

end
