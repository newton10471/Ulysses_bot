require 'sinatra'
require './litbot'

paragraph_size = 10
bender = LitBot.new
bender.eat_file("huckle.txt")
# bender.speak_first_10_words # an example call
bender.digest_file
puts bender.speak(paragraph_size)
# p "#{bender.object_id} #{bender.word_pairs_and_probabilities.size}"

ulysses_bot = LitBot.new
ulysses_bot.eat_file("ulysses.txt")
# ulysses.speak_first_10_words # an example call
ulysses_bot.digest_file
puts ulysses_bot.speak(paragraph_size)
# p "#{ulysses_bot.object_id} #{ulysses_bot.word_pairs_and_probabilities.size}"

# BONUS HW
hybrid_bot = ulysses_bot + bender
puts hybrid_bot.speak(paragraph_size)
# p "#{hybrid_bot.object_id} #{hybrid_bot.word_pairs_and_probabilities.size}"

get '/hi' do
    "Hello World"
end

get '/hi-matt' do
  "Hi there, Matt!"
end

get '/hybrid_bot' do
  hybrid_bot.speak(paragraph_size)
end
