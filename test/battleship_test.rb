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

  def test_assign_user_ships_prompts_for_and_performs_validation_for_each_and_assigns_both_ships
    @battleship.assign_user_ships

    refute_equal [], @battleship.players[0].owner_board.two_ship_location
    refute_equal [], @battleship.players[0].owner_board.three_ship_location
  end

  def test_assign_computer_ships_validates_and_assigns_both_randomly_placed_ships
    @battleship.assign_computer_ships

    refute_equal [], @battleship.players[1].owner_board.two_ship_location
    refute_equal [], @battleship.players[1].owner_board.three_ship_location
  end

end
