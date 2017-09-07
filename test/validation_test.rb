require 'minitest/autorun'
require 'minitest/emoji'

require './lib/validation'

class ValidationTest < Minitest::Test

  attr_reader :validation

  def setup
    @validation = Validation.new("A1","A2","two-unit", "User")
  end

  def test_validation_exists
    assert_instance_of Validation, @validation
  end

  def test_has_default_result_of_false
    refute @validation.result
  end

  def test_validation_is_created_with_head_and_tail_that_are_instances_of_coordinates
    assert_instance_of Coordinates, @validation.head
    assert_instance_of Coordinates, @validation.tail
  end

  def test_validation_has_a_potential_middle_of_a_head_and_tail_defaulted_to_nil
    assert_nil @validation.middle
  end

  def test_validation_has_a_optional_two_ship_location_that_defaults_to_nil
    assert_nil @validation.two_ship_location

    validation = Validation.new("A1","A3","three-unit", "User", ["B2","B3"])

    assert_equal ["B2","B3"], validation.two_ship_location
  end

  def test_perform_validation_refutes_ship_positions_that_arent_on_the_board_for_two_unit_ship
    validation = Validation.new("Z1","A2","two-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("A5","A2","two-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("A1","Z2","two-unit", "User")
    refute validation.perform_validation
  end

  def test_perform_validation_refutes_ship_positions_if_they_are_not_next_to_each_other_for_two_unit_ship
    validation = Validation.new("A1","A3","two-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("A1","A1","two-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("B1","A2","two-unit", "User")
    refute validation.perform_validation
  end

  def test_perform_validation_asserts_a_valid_ship_position_for_two_unit_ship
    validation = Validation.new("A1","A2","two-unit", "User")
    assert validation.perform_validation
    validation = Validation.new("B1","B2","two-unit", "User")
    assert validation.perform_validation
    validation = Validation.new("D1","C1","two-unit", "User")
    assert validation.perform_validation
    validation = Validation.new("D4","D3","two-unit", "User")
    assert validation.perform_validation
  end

  def test_perform_validation_refutes_ship_positions_that_arent_on_the_board_for_three_unit_ship
    validation = Validation.new("Z1","A2","three-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("A5","A2","three-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("A1","Z2","three-unit", "User")
    refute validation.perform_validation
  end

  def test_perform_validation_refutes_ship_positions_if_the_head_and_tail_are_not_separated_either_vertically_or_horizontally_by_one_spot_for_three_unit_ship
    validation = Validation.new("A1","A2","three-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("A1","A4","three-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("B1","A2","three-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("D4","C4","three-unit", "User")
    refute validation.perform_validation
    validation = Validation.new("D4","A4","three-unit", "User")
    refute validation.perform_validation
  end

  def test_perform_validation_refutes_ship_positions_if_either_position_coincides_with_a_two_ship_position_for_three_unit_ship
    validation = Validation.new("B1","B3","three-unit", "User", ["B2","B3"])
    refute validation.perform_validation
    validation = Validation.new("A2","C2","three-unit", "User", ["B2","B3"])
    refute validation.perform_validation
  end

  def test_perform_validation_asserts_a_valid_ship_position_for_three_unit_ship
    validation = Validation.new("A1","A3","three-unit", "User", ["B2","B3"])
    assert validation.perform_validation
    validation = Validation.new("A1","C1","three-unit", "User", ["B2","B3"])
    assert validation.perform_validation
    validation = Validation.new("D4","D2","three-unit", "User", ["B2","B3"])
    assert validation.perform_validation
    validation = Validation.new("B4","D4","three-unit", "User", ["B2","B3"])
    assert validation.perform_validation
  end

  def test_create_middle_for_three_ship
    validation = Validation.new("A1","A3","three-unit", "User", ["B2","B3"])
    assert_nil validation.middle
    validation.create_middle_for_three_ship

    assert_equal "A2", validation.middle.location
  end


end
