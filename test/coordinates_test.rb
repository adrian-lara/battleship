require 'minitest/autorun'
require 'minitest/emoji'

require './lib/coordinates'

class CoordinatesTest < Minitest::Test

  attr_reader :coordinates
  def setup
    @coordinates = Coordinates.new("A1")
  end

  def test_coordinates_class_exists
    assert_instance_of Coordinates, @coordinates
  end

  def test_coordinates_has_a_location_component_that_is_of_length_2
    assert_equal 2, @coordinates.location.length
  end

  def test_valid_returns_whether_given_location_is_valid
    coordinates1 = Coordinates.new("B1")
    assert coordinates1.valid?

    coordinates2 = Coordinates.new("A4")
    assert coordinates2.valid?

    coordinates3 = Coordinates.new("a4")
    assert coordinates3.valid?

    coordinates4 = Coordinates.new("")
    refute coordinates4.valid?

    coordinates5 = Coordinates.new("11")
    refute coordinates5.valid?

    coordinates5 = Coordinates.new("BC")
    refute coordinates5.valid?
  end

  def test_row_number_returns_row_number_according_to_first_character_of_location
    coordinates1 = Coordinates.new("B1")
    assert_equal 1, coordinates1.row_number

    coordinates2 = Coordinates.new("C2")
    assert_equal 2, coordinates2.row_number
  end

  def test_column_number_returns_integer_provided_by_second_character_of_location
    coordinates1 = Coordinates.new("B1")
    assert_equal 1, coordinates1.column_number

    coordinates2 = Coordinates.new("C2")
    assert_equal 2, coordinates2.column_number
  end

end
