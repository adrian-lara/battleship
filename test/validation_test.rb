require 'minitest/autorun'
require 'minitest/emoji'

require './lib/validation'

class ValidationTest < Minitest::Test


  def test_result_refutes_ship_positions_that_arent_on_the_board_for_two_unit_ship
    validation = Validation.new("Z1","A2","two_unit")
    refute validation.result?
    validation = Validation.new("A5","A2","two_unit")
    refute validation.result?
    validation = Validation.new("A1","Z2","two_unit")
    refute validation.result?
  end

  def test_result_refutes_ship_positions_if_they_are_not_next_to_each_other_for_two_unit_ship
    validation = Validation.new("A1","A3","two_unit")
    refute validation.result?
    validation = Validation.new("A1","A1","two_unit")
    refute validation.result?
    validation = Validation.new("B1","A2","two_unit")
    refute validation.result?
  end

  def test_result_asserts_a_valid_ship_position_for_two_unit_ship
    validation = Validation.new("A1","A2","two_unit")
    assert validation.result?
    validation = Validation.new("B1","B2","two_unit")
    assert validation.result?
    validation = Validation.new("D1","C1","two_unit")
    assert validation.result?
    validation = Validation.new("D4","D3","two_unit")
    assert validation.result?
  end

  def test_result_refutes_ship_positions_that_arent_on_the_board_for_three_unit_ship
    validation = Validation.new("Z1","A2","three_unit")
    refute validation.result?
    validation = Validation.new("A5","A2","three_unit")
    refute validation.result?
    validation = Validation.new("A1","Z2","three_unit")
    refute validation.result?
  end

  def test_result_refutes_ship_positions_if_the_head_and_tail_are_not_separated_either_vertically_or_horizontally_by_one_spot_for_three_unit_ship
    validation = Validation.new("A1","A2","three_unit")
    refute validation.result?
    validation = Validation.new("A1","A4","three_unit")
    refute validation.result?
    validation = Validation.new("B1","A2","three_unit")
    refute validation.result?
    validation = Validation.new("D4","C4","three_unit")
    refute validation.result?
    validation = Validation.new("D4","A4","three_unit")
    refute validation.result?
  end

  def test_result_refutes_ship_positions_if_either_position_coincides_with_a_two_ship_position_for_three_unit_ship
    validation = Validation.new("B1","B3","three_unit")
    validation.two_ship_location = ["B2","B3"]

    refute validation.result?
    validation = Validation.new("A2","C2","three_unit")
    validation.two_ship_location = ["B2","B3"]

    refute validation.result?
  end

  def test_result_asserts_a_valid_ship_position_for_three_unit_ship
    validation = Validation.new("A1","A3","three_unit")
    validation.two_ship_location = ["B2","B3"]

    assert validation.result?
    validation = Validation.new("A1","C1","three_unit")
    validation.two_ship_location = ["B2","B3"]

    assert validation.result?
    validation = Validation.new("D4","D2","three_unit")
    validation.two_ship_location = ["B2","B3"]

    assert validation.result?
    validation = Validation.new("B4","D4","three_unit")
    validation.two_ship_location = ["B2","B3"]

    assert validation.result?
  end

end
