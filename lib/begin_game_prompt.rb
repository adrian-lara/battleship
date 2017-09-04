puts "Welcome to BATTLESHIP\n\n"

def prompt_begin
  puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n>"
end

def print_instructions
  puts "Insert instructions"
end

begin_choice = ""

while begin_choice != "p"
  prompt_begin
  begin_choice = gets.chomp

  break if begin_choice == "q"
  print_instructions if begin_choice == "i"

  if begin_choice == "p"
    game = Battleship.new
    # game.begin
  end
end
