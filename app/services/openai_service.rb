class OpenaiService
  def initialize
    @client = Openai::Client.new
  end

  def generate_response(message)
  #   @client.create_completion(
  #     engine: 'text-davinci-003',
  #     prompt: prompt,
  #     max_tokens: 100
  #   )
  puts '-' * 50
  puts "Generating the response..."
  puts '-' * 50
  response = client.chat(
    parameters: {
      model: "gpt-4o-mini",
      messages: [
        { role: "user", content: message }
      ],
      temperature: 0.7,
  })
  response.dig("choices", 0, "message", "content")

  end
end
