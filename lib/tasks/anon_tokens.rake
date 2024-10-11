namespace :anon_tokens do
  desc "Generate a new anonymous token valid for 1 day"
  task generate: :environment do
    token = Nanoid.generate(size: 21) # Generates a 21-character nanoid
    expires_at = 1.day.from_now

    AnonToken.create!(token: token, expires_at: expires_at)

    puts "Generated token: #{token}"
    puts "Expires at: #{expires_at}"
  end
end
