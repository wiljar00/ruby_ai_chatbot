require 'http'
require 'json'

class ChatBot 
  
  def  initialize
    # TODO: create a .env file and store the OPENAI_API_KEY in it
    @openai_api_key = 'your_openai_api_key_here'
    @chat_model = 'gpt-4' # or 'gpt-3.5-turbo'
  end

  def chat_with_openai(prompt)
    url = 'https://api.openai.com/v1/chat/completions'
  
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{@openai_api_key}"
    }
  
    body = {
      model: @chat_model,
      messages: [
        { role: 'system', content: 'You are a helpful assistant.' },
        { role: 'user', content: prompt }
      ],
      max_tokens: 150
    }
  
    response = HTTP.headers(headers).post(url, json: body)
  
    if response.status.success?
      data = JSON.parse(response.body.to_s)
      return data['choices'][0]['message']['content']
    else
      return "Error: #{response.status} - #{response.body.to_s}"
    end
  end

  def run_chatbot
    puts "Chatbot: Hello! Ask me anything."
    loop do
      print "You: "
      user_input = gets.chomp
      break if user_input.downcase == 'exit'
    
      reply = chat_with_openai(user_input)
      puts "Chatbot: #{reply}"
    end
  end
end

