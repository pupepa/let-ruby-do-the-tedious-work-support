require "readline"
require "openai"

class OpenAIChat
  def initialize
    # OpenAIのクライアントを作成
    openai_api_key = ENV["OPENAI_API_KEY"]
    @client = OpenAI::Client.new(access_token: openai_api_key)

    # 会話の履歴を初期化
    @messages = []
  end

  def start
    loop do
      # ユーザーからの入力を受け付ける
      message = Readline.readline("> ", true)

      if ["exit", "quit"].include?(message)
        # exitまたはquitが入力されたら終了する
        puts "bye"
        break
      end

      # チャットを行う
      puts chat(message)
      puts ""
    end
  rescue Interrupt
    # Ctrl-Cが入力されたら終了する
    puts "bye"
  end

  private

  def chat(message)
    @messages << { role: "user", content: message }

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: @messages,
        temperature: 1.0,
      }
    )

    response_message = response.dig("choices", 0, "message")

    @messages << response_message

    response_message["content"]
  end
end

OpenAIChat.new.start
