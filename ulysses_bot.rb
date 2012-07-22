class LitBot
  attr_accessor :word_pairs_and_probabilities, :source_text

  def eat_file(file_name)
    file = File.open(file_name)
    @source_text = file.read
    file.close
  end

  def speak_first_10_words
    puts @source_text.split(' ').first(10)
  end

  def digest_file
    source_text_words = @source_text.split(' ')
    @word_pairs_and_probabilities = {}

    source_text_words.each_with_index do |word, index|
      hash_key = "#{word} #{source_text_words[index + 1]}"
      hash_value = source_text_words[index + 2]
      if @word_pairs_and_probabilities[hash_key]
        @word_pairs_and_probabilities[hash_key] << hash_value
      else
        @word_pairs_and_probabilities[hash_key] = [hash_value]
      end
    end
  end

  def speak_first_word
    puts @word_pairs_and_probabilities.first
  end

  def pick_first_two_words_slow_but_random
    two_words = []
    while (@word_pairs_and_probabilities[two_words.join(' ')] == nil) do
      two_words = @source_text.split(' ').sample(2)
      two_words[0] = two_words[0].capitalize
    end
    return two_words
  end

  def pick_first_two_words
    two_words = []
    two_words = @source_text.split(' ').first(2)
    return two_words
  end

  # num is number of sentences
  def speak(num)
    new_text = pick_first_two_words
    while (num > 0) do
      hash_key = "#{new_text[-2]} #{new_text[-1]}"
      new_word = @word_pairs_and_probabilities[hash_key].sample 
      new_text <<  new_word unless new_word == nil
      if /\./.match(new_word)
        num -= 1 
      end
    end
    return new_text.join(" ")
  end

  def +(added_bot)
    result = dup
    result.source_text = result.source_text + added_bot.source_text
    result.word_pairs_and_probabilities = result.word_pairs_and_probabilities.merge(added_bot.word_pairs_and_probabilities)
    return result
  end

end

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

# ulysses = File.open("ulysses.txt")
# source_text = ulysses.read
# ulysses.close

# source_text_words = source_text.split(' ')
# word_pairs_and_probabilities = {}

# source_text_words.each_with_index do |word, index|
  # hash_key = "#{word} #{source_text_words[index + 1]}"
  # hash_value = source_text_words[index + 2]
  # if word_pairs_and_probabilities[hash_key]
    # word_pairs_and_probabilities[hash_key] << hash_value
  # else
    # word_pairs_and_probabilities[hash_key] = [hash_value]
  # end
# end

# # puts word_pairs_and_probabilities
# output_text = ['They', 'came']

# story = 0
# while story < 35 do
  # word_pair = output_text.last(2).join(' ')
  # next_word = word_pairs_and_probabilities[word_pair].sample unless word_pairs_and_probabilities[word_pair].nil?
  # output_text << next_word

  # if next_word && (next_word.include?(".") || next_word.include?("?"))
    # story += 1
  # end
# end
# puts output_text.join(' ')