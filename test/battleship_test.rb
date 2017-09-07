require 'minitest/autorun'
require 'minitest/emoji'

require './lib/battleship'


class BattleshipTest < Minitest::Test

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

#TODO will be outdated after a while
  def test_main_phase_makes_a_player_create_and_take_a_turn_and_save_it_in_shot_history
    skip
    assert_equal 0, @battleship.players[0].turn_history.count
    @battleship.main_phase

    assert_equal 1, @battleship.players[0].turn_history.count
    assert_instance_of Turn, @battleship.players[0].turn_history[0]
  end

  #TODO will be outdated after a while
    def test_main_phase_makes_a_computer_create_and_take_a_turn_and_save_it_in_shot_history
      skip
      assert_equal 0, @battleship.players[1].turn_history.count
      @battleship.main_phase

      assert_equal 1, @battleship.players[1].turn_history.count
      assert_instance_of Turn, @battleship.players[1].turn_history[0]
    end

#need to set this up still
#set up game where computer has one ship coordinate left
#check @winner = "user"
  def test_hit_sequence_removes_ship_coordinate_from_opponent_ship_location_array
    @battleship.players[1].two_ship_location = ["A1"]
    p @battleship.players[1].two_ship_location
    p @battleship.players[1].three_ship_location
    @battleship.main_phase

    refute_nil @battleship.winner
    p @battleship.players[0].turn_history
    p @battleship.players[1].turn_history
  end

end
