class Coordinates

  attr_reader :location

  def initialize(location)
    @location = location
    @possible_rows = ("A".."D").to_a
    @possible_columns = (1..4).to_a
  end

  def valid?
    return false unless @location.length == 2
    return false unless @possible_rows.include?(@location[0].upcase)
    return false unless @possible_columns.include?(@location[1].to_i)
    true
  end

  def row
    @location[0]
  end

  def row_number
    @possible_rows.index(@location[0])
  end

  def column_number
    @location[1].to_i
  end

end
