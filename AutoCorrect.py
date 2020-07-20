def create_bigram(word):
  return [word[i] + word[i+1] for i in range(len(word)-1)]

def get_similarity_ratio(word1, word2):
  word1, word2 = word1.lower(), word2.lower()

  common = []

  bigram1, bigram2 = create_bigram(word1), create_bigram(word2)

  for i in range(len(bigram1)):
    # common elt
    try:
      cmn_elt = bigram2.index(bigram1[i])
      common.append(bigram1[i])
    except:
      continue
  
  return len(common)/max(len(bigram1), len(bigram2))


def AutoCorrect(word, database={'falcon', 'dragon', 'etc'}, sim_threshold=0.5):
  max_sim = 0.0
  most_sim_word = word

  for data_word in database:
    cur_sim = get_similarity_ratio(word, data_word)
    if cur_sim > max_sim:
      max_sim = cur_sim
      most_sim_word = data_word

  return most_sim_word if max_sim>sim_threshold else word





if __name__ == "__main__":
  # print(create_bigram('falicon'))


  # print(get_similarity_ratio('falcon', 'falicon'))


  print(AutoCorrect('falicon'))
