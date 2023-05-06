require 'telegram/bot'
require_relative 'token'

Telegram::Bot::Client.run(@token) do |bot|
  bot.listen do |message|

    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Стартуеееем!")
    when '/напоминание'
      bot.api.send_message(chat_id: message.chat.id, text: "Когда напомнить?")
      bot.listen do |mes|
        if mes.text =~ /напомни через (\d+) (секунду|секунд|минуту|минут|час|часа|день|дней)/ #
          delay = $1.to_i
          unit = $2
          #delay_seconds = nil
    
          case unit
          when 'секунду'
            delay_seconds = delay
          when 'секунд'
            delay_seconds = delay
          when 'минут'
            delay_seconds = delay * 60
          when 'минуту'
            delay_seconds = delay * 60
          when 'час'
            delay_seconds = delay * 60 * 60
          when 'часа'
            delay_seconds = delay * 60 * 60
          when 'день'
            delay_seconds = delay * 24 * 60 * 60
          when 'дней'
            delay_seconds = delay * 24 * 60 * 60
          end

          #bot.api.send_message(chat_id: message.chat.id, text: delay_seconds)
    
          if delay_seconds.nil?
            bot.api.send_message(chat_id: message.chat.id, text: "Я не понимаю, сколько времени нужно подождать")
            next
          end
    
          unless delay_seconds.nil?
            bot.api.send_message(chat_id: message.chat.id, text: "хорошо я вам напомню")
            next
          end
    
          Thread.new do
            sleep(delay_seconds)
            bot.api.send_message(chat_id: message.chat.id, text: "Время для напоминания!")
          end
        end
      end
    end
  end
end