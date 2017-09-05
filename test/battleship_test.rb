require 'minitest/autorun'
require 'minitest/emoji'

require './lib/battleship'


class BattleshipTest < Minitest::Test

  def test_the_file_starts_with_prompt
    skip
    File.open('./lib/battleship', "r")
  end

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

  def test_assign_two_ship_location_prompts_user_for_two_positions_and_inputs_that_into_location
    @battleship.assign_two_ship_location

    refute_equal [], @battleship.players[0].owner_board.two_ship_location
  end

end
