class LitBot
  # attr_accessor :word_pairs_and_probabilities, :source_text

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

  def pick_first_two_words_slow_but_random # and, it turns out, stupid :)
    two_words = []
    while (@word_pairs_and_probabilities[two_words.join(' ')] == nil) do
      two_words = @source_text.split(' ').sample(2)
      two_words[0] = two_words[0].capitalize
    end
    return two_words
  end

  # def pick_first_two_words_notrandom
  #   two_words = []
  #   two_words = @source_text.split(' ').first(2)
  #   return two_words
  # end

  def pick_first_two_words_fast
    @word_pairs_and_probabilities.keys.sample.split(' ')
  end

  def pick_first_two_words
    trial_pair = @word_pairs_and_probabilities.keys.sample
    until trial_pair[0] == trial_pair[0].upcase do 
      trial_pair = @word_pairs_and_probabilities.keys.sample
    end
    trial_pair.split(' ')
  end

  # num is number of sentences
  def speak(num)
    new_text = pick_first_two_words
    while (num > 0) do
      hash_key = "#{new_text[-2]} #{new_text[-1]}"
      new_word = @word_pairs_and_probabilities[hash_key].sample 
      new_text <<  new_word unless new_word.nil?
      if /\./.match(new_word)
        num -= 1 
      end
    end
    return new_text.join(" ")
  end

  # def +(added_bot)
  #   result = dup
  #   result.source_text = result.source_text + added_bot.source_text
  #   result.word_pairs_and_probabilities = result.word_pairs_and_probabilities.merge(added_bot.word_pairs_and_probabilities)
  #   return result
  # end

  def +(added_bot)
    result_bot = LitBot.new
    result_bot.source_text = @source_text + added_bot.source_text
    result_bot.word_pairs_and_probabilities = @word_pairs_and_probabilities.merge(added_bot.word_pairs_and_probabilities)
    return result_bot
  end

  def source_text
    @source_text
  end

  def source_text=(text)
    @source_text = text
  end

  def word_pairs_and_probabilities
    @word_pairs_and_probabilities
  end

  def word_pairs_and_probabilities=(probabilities)
    @word_pairs_and_probabilities = probabilities
  end

  def initialize(text="dummy string")
    source_text = text
  end

end
