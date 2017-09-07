require 'minitest/autorun'
require 'minitest/emoji'

require './lib/game'
require './lib/player'


class GameTest < Minitest::Test

  attr_reader :game
  def setup
    @game = Game.new
  end

  def test_game_game_can_be_created
    assert_instance_of Game, @game
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

  def test_start_time_sets_timer_equal_to_an_instance_of_the_time_class
    assert_nil @game.timer
    @game.start_time

    assert_instance_of Time, @game.timer
  end

  def test_end_time_sets_timer_to_different_time
    start = @game.start_time
    assert_equal start, @game.timer

    time_end = @game.end_time
    refute_equal start, @game.timer
  end

end
