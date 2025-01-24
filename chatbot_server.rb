require 'sinatra'
require 'http'
require 'json'

class ChatBotServer
  def initialize
    @openai_api_key = ENV['OPENAI_API_KEY']
    @chat_model = 'gpt-4'
  end

  def chat_with_openai(prompt)
    url = 'https://api.openai.com/v1/chat/completions'
    headers = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{OPENAI_API_KEY}" }
    body = {
      model: 'gpt-4',
      messages: [
        { role: 'system', content: 'You are a helpful assistant.' },
        { role: 'user', content: prompt }
      ],
      max_tokens: 150
    }
  
    response = HTTP.headers(headers).post(url, json: body)
    return JSON.parse(response.body.to_s)['choices'][0]['message']['content'] if response.status.success?
  
    "Error: #{response.status} - #{response.body.to_s}"
  end

  def run_server
    post '/chat' do
      request_payload = JSON.parse(request.body.read)
      prompt = request_payload['prompt']
      content_type :json
      { reply: chat_with_openai(prompt) }.to_json
    end
  end
end

chatbot_server = ChatBotServer.new
chatbot_server.run_server