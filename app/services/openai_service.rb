class OpenaiService
  def initialize
    @client = OpenAI::Client.new
  end

  def generate_response(message)
  #   @client.create_completion(
  #     engine: 'text-davinci-003',
  #     prompt: prompt,
  #     max_tokens: 100
  #   )
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "user", content: message }
        ],
        temperature: 0.7,
    })
    response.dig("choices", 0, "message", "content")

  end
end
