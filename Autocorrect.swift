// ** AUTOCORRECT **
    func create_bigrams(word: String) -> Array<String>{
        var bigrams:Array<String> = []
        let index = word.index(word.startIndex, offsetBy: 1) // the str_index (not int) of the 2nd char
        let end_ind = word.index(word.endIndex, offsetBy: -1)
        
        for (char, nextChar) in zip(word, word[index...end_ind]){ // zip of regular word and word[1:]
            bigrams.append(String(char) + String(nextChar))
        }
        
        return bigrams
    }
    
    func get_similarity(w1: String, w2: String) -> Double {
        let word1 = w1.lowercased(); let word2 = w2.lowercased() // make inputs lowercase
        
        let bigram1 = create_bigrams(word: word1); let bigram2 = create_bigrams(word: word2) // bigrams of both words
        
        var similarity = 0.0
        
        for b in bigram1 { // loop thru bigram1
            if bigram2.contains(b) { // bigram2 contains current element of bigram1
                similarity += 1
            }
        }
        
        return similarity/Double(max(bigram1.count, bigram2.count)) // number of common elements over the higher len of array
    }
    
    func AutoCorrect(word: String, database:Set<String>?, sim_thresh:Double = 0.5) -> String { // optional database Set of strings
        let database = database ?? Set(current_rhymes) // if no database was passed in, use the current_rhymes (as a Set)
        
        var max_sim = 0.0
        var current_sim = 0.0
        var most_sim_word = word
        
        
        for data_word in database { // loop thru database
            current_sim = get_similarity(w1: word, w2: data_word)
            
            if (current_sim > max_sim) { // find max similarity
                max_sim = current_sim
                most_sim_word = data_word
            }
        }
        
        return max_sim > sim_thresh ? most_sim_word : word // ternary to return the most similar word if the maximum sim is greater than the threshold (0.5), else return input word
    }

    
    
    func correctSpellingForAll(userWords:inout Array<String>) {
        for i in 0...userWords.count {
            userWords[i] = AutoCorrect(word: userWords[i], database: Set(current_rhymes))
        }
    }
