source_text = <<EOF
They came down the steps from Leahy's terrace prudently, Frauenzimmer: and down the shelving shore flabbily, their splayed feet sinking in the silted sand. Like me, like Algy, coming down to our mighty mother. Number one swung lourdily her midwife's bag, the other's gamp poked in the beach. From the liberties, out for the day. Mrs Florence MacCabe, relict of the late Patk MacCabe, deeply lamented, of Bride Street. One of her sisterhood lugged me squealing into life. Creation from nothing. What has she in the bag? A misbirth with a trailing navelcord, hushed in ruddy wool. The cords of all link back, strandentwining cable of all flesh. That is why mystic monks. Will you be as gods? Gaze in your omphalos. Hello! Kinch here. Put me on to Edenville. Aleph, alpha: nought, nought, one.
Spouse and helpmate of Adam Kadmon: Heva, naked Eve. She had no navel. Gaze. Belly without blemish, bulging big, a buckler of taut vellum, no, whiteheaped corn, orient and immortal, standing from everlasting to everlasting. Womb of sin.
Wombed in sin darkness I was too, made not begotten. By them, the man with my voice and my eyes and a ghostwoman with ashes on her breath. They clasped and sundered, did the coupler's will. From before the ages He willed me and now may not will me away or ever. A lex eterna stays about Him. Is that then the divine substance wherein Father and Son are consubstantial? Where is poor dear Arius to try conclusions? Warring his life long upon the contransmagnificandjewbangtantiality. Illstarred heresiarch' In a Greek watercloset he breathed his last: euthanasia. With beaded mitre and with crozier, stalled upon his throne, widower of a widowed see, with upstiffed omophorion, with clotted hinderparts.
Airs romped round him, nipping and eager airs. They are coming, waves. The whitemaned seahorses, champing, brightwindbridled, the steeds of Mananaan.
I mustn't forget his letter for the press. And after? The Ship, half twelve. By the way go easy with that money like a good young imbecile.
Yes, I must.
His pace slackened. Here. Am I going to aunt Sara's or not? My consubstantial father's voice. Did you see anything of your artist brother Stephen lately? No? Sure he's not down in Strasburg terrace with his aunt Sally? Couldn't he fly a bit higher than that, eh? And and and and tell us, Stephen, how is uncle Si? O, weeping God, the things I married into! De boys up in de hayloft. The drunken little costdrawer and his brother, the cornet player. Highly respectable gondoliers! And skeweyed Walter sirring his father, no less! Sir. Yes, sir. No, sir. Jesus wept: and no wonder, by Christ!
EOF


words = source_text.split(' ')  # for now read this from the above-defined variable, but later on read from a file
probabilities = {}
new_text = []

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
    # p "new_first_word: #{new_first_word} probable_following_word: #{probable_following_word} dummy: #{dummy}"
    current_two_words = new_first_word + " " + probable_following_word    # make the probable_following_word the new rightmost word of current_two_words
    # p "current_two_words is #{current_two_words}"
  end
end

puts new_text.join(" ")

