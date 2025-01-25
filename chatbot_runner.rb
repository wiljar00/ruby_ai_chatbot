# script to run the chatbot according to the user's input

require_relative 'chatbot/chatbot_console'
require_relative 'chatbot/chatbot_server'

class ChatbotRunner
  def run 
    print_introduction
    user_input = get_user_input

    if user_input == "exit"
      puts "Thank you for using the chatbot! Goodbye!"
    else
      puts "Invalid input. " unless is_valid_input?(user_input)
      switch_to_console_mode if user_input == "console"
      switch_to_server_mode if user_input == "server"
    end
  end

  private

  # introduction to the app:
  def print_introduction
    puts "\nWelcome to the chatbot! I'm here to help you with your questions."
    puts "If you would like to run the chatbot in console mode, please type 'console'."
    puts "If you would like to run the chatbot in server mode, please type 'server'."
    puts "Please enter 'exit' at any time to leave.\n"
  end

  # get the user's input
  def get_user_input
    print "> "
    gets.chomp
  end

  # check if the user's input is valid
  def is_valid_input?(input)
    input == "console" || input == "server" || input == "exit"
  end

  def switch_to_console_mode
    puts "\nWelcome to the chatbot console! Please enter your question or type 'exit' to leave.\n"
    Chatbot::ChatbotConsole.new.run_chatbot
  end

  def switch_to_server_mode
    puts "\nWelcome to the chatbot server! Please enter your question or type 'exit' to leave.\n"
    Chatbot::ChatbotServer.run_server
  end
end

runner = ChatbotRunner.new  
runner.run