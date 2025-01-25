# script to run the chatbot according to the user's input

class ChatbotRunner

  def run 
    print_introduction
    user_input = get_user_input
  end

  private

  # introduction to the app:
  def print_introduction
    puts "Welcome to the chatbot! I'm here to help you with your questions."
    puts "Please enter your question or type 'exit' to leave."
  end

  # get the user's input
  def get_user_input
    gets.chomp
  end
end



runner = ChatbotRunner.new  
runner.run

