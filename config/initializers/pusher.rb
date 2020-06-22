require 'pusher'

Pusher.url = "https://#{ENV["PUSHER_APP_KEY"]}:#{ENV["PUSHER_APP_SECRET"]}@api.pusherapp.com/apps/#{ENV["PUSHER_APP_ID"]}"
Pusher.logger = Rails.logger
Pusher.encrypted = true
