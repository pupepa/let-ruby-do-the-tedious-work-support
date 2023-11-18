# frozen_string_literal: true

require "openai"

openai_api_key = ENV["OPENAI_API_KEY"]
client = OpenAI::Client.new(access_token: openai_api_key)

response = client.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: [{ role: "user", content: "こんにちは" }],
    temperature: 1.0,
  }
)

puts response.dig("choices", 0, "message", "content")
