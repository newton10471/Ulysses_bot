def read_file(filename)
  file_text = []
  f = File.open(filename,"r")
  f.each do |line|
    file_text += line.split(" ")
  end
  return file_text
end

def build_probabilities(source_text_words)
  word_pairs_and_probabilities = {}
  source_text_words.each_with_index do |word, index|
    hash_key = "#{word} #{source_text_words[index + 1]}"
    hash_value = source_text_words[index + 2]
    if word_pairs_and_probabilities[hash_key] 
      word_pairs_and_probabilities[hash_key] << hash_value
    else
        word_pairs_and_probabilities[hash_key] = [hash_value]
    end
  end
  return word_pairs_and_probabilities
end

def pick_two_words(source_text_words, word_pairs_and_probabilities)
  # randomly pick the first two words, until we find a hit
  found = false
  while (found == false) do
    two_sample_words = source_text_words.sample(2).join(" ")
    if word_pairs_and_probabilities[two_sample_words] != nil
      found = true
    end
  end
  # return a single string containing the two words, suitable as a hash key
  return two_sample_words
end

probabilities = {}
new_text = []
words = read_file("ulysses.txt")
probabilities = build_probabilities(words)
current_two_words = pick_two_words(words, probabilities)

#get the first following word
probable_following_word = probabilities[current_two_words]
# populate the new text with the first two new words
new_text << current_two_words.split(" ")

# for now, just spit out as much text as comes in
probabilities.each do |dummy|
  found = false
  while (found == false) do
    try_following_word = probabilities[current_two_words]   # find and pick a candidate following word
    if (try_following_word != nil)
      found = true                                          # if we find a match (a non-nil value), break out of while loop
      probable_following_word = try_following_word.sample
    end  
  end

  if (probable_following_word == nil)
    current_two_words = pick_two_words(words, probabilities)
  else   
    new_text << probable_following_word                                 # tack the new word on the end of the new_text array
    new_first_word = current_two_words.split(" ")[1]                    # shift rightmost word of current_two_words to the left
    current_two_words = new_first_word + " " + probable_following_word    # make the probable_following_word the new rightmost word of current_two_words
  end
end

puts new_text.join(" ")

