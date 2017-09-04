require 'pry'

class Board

  attr_reader :size, :border, :header_row
  attr_accessor :two_unit_ship, :three_unit_ship, :working_rows
  
  def initialize(size = 4)
    @size = size
    @border = ""
    @working_rows = []
    @header_row = []
    @two_unit_ship = []
    @three_unit_ship = []
  end

  def create_board(size = @size)
    create_border(size)
    create_header_row(size)
    create_working_rows(size)
  end

  def create_border(size)
    @border = "=" * (2 + (size * 2))
  end

  def create_header_row(size)
    @header_row = (1..size).to_a
    @header_row.unshift(".")
    @header_row = @header_row.join(" ")
  end

  def create_working_rows(size)
    letters = ("A".."L").to_a
    count = 0

    until count == size
      row = []
      row << letters[count]
      size.times { row << " " }
      @working_rows << row
      count += 1
    end
  end

  def print_board
    puts ["\n",@border, @header_row]

    @working_rows.each { |row| print "#{row.join(" ")}\n" }

    puts @border
  end

end
