require 'khipu-api-client'

receiver_id = ENV['RECEIVER_ID']
secret_key = ENV['RECEIVER_SECRET']

Khipu.configure do |c|
  c.secret = secret_key
  c.receiver_id = receiver_id
  c.platform = 'demo-client'
  c.platform_version = '2.0'
  # c.debugging = true
end

