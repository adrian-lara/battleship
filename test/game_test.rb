require 'minitest/autorun'
require 'minitest/emoji'

require './lib/game'


class GameTest < Minitest::Test

  attr_reader :game
  def setup
    @game = Game.new
  end

  def test_game_game_can_be_created
    assert_instance_of Game, @game
  end

  def test_game_starts_with_nil_game_status
    assert_nil @game.status
  end

  def test_game_starts_with_array_of_two_players
    assert_instance_of Player, @game.players[0]
    assert_instance_of Player, @game.players[1]
  end

  def test_game_starts_with_nil_timer
    assert_nil @game.timer
  end

  def test_game_starts_with_nil_winner
    assert_nil @game.winner
  end

#TODO will be outdated after a while
  def test_main_phase_makes_a_player_create_and_take_a_turn_and_save_it_in_shot_history
    skip
    assert_equal 0, @game.players[0].turn_history.count
    @game.main_phase

    assert_equal 1, @game.players[0].turn_history.count
    assert_instance_of Turn, @game.players[0].turn_history[0]
  end

#TODO will be outdated after a while
  def test_main_phase_makes_a_computer_create_and_take_a_turn_and_save_it_in_shot_history
    skip
    assert_equal 0, @game.players[1].turn_history.count
    @game.main_phase

    assert_equal 1, @game.players[1].turn_history.count
    assert_instance_of Turn, @game.players[1].turn_history[0]
  end

  def test_hit_sequence_removes_ship_coordinate_from_opponent_ship_location_array
    @game.main_phase

    refute_nil @game.winner
    p @game.players[0].turn_history
    p @game.players[1].turn_history
  end

end
