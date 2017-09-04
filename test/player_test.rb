require 'minitest/autorun'
require 'minitest/emoji'

require './lib/player'

class PlayerTest < Minitest::Test

  def test_player_exists
    player_1 = Player.new

    assert_instance_of Player, player_1
  end

  attr_reader :player
  def setup
    @player = Player.new
  end

  def test_player_has_a_board
    assert_instance_of Board, @player.board
  end

  def test_player_has_a_user_type
    assert_instance_of String, @player.user_type
  end


end
