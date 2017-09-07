require 'minitest/autorun'
require 'minitest/emoji'

require './lib/welcome_messages'

class WelcomeMessagesTest < Minitest::Test

  def test_prompt_begin_can_be_called_without_error
    WelcomeMessages.prompt_begin
  end

  def test_print_instructions_can_be_called_without_error
    WelcomeMessages.print_instructions
  end

  def test_print_start_can_be_called_without_error
    WelcomeMessages.print_start
  end

end
