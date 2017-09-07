require './lib/game'
require './lib/welcome_messages'

puts "Welcome to BATTLESHIP\n\n"

begin_choice = ""

while begin_choice != "p"
  WelcomeMessages.prompt_begin
  begin_choice = gets.chomp

  break if begin_choice == "q"
  WelcomeMessages.print_instructions if begin_choice == "i"
  if begin_choice == "p"
    WelcomeMessages.print_start
    Game.new.run
  end

end
