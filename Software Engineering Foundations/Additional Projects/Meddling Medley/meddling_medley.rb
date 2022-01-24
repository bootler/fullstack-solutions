# Meddling Medley - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/meddling-medley
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require('byebug')

# ----Phase 1:----

# Problem 1:
# Write a method duos that accepts a string as an argument and returns 
# the count of the number of times the same character appears consecutively 
# in the given string.
def duos(str)
    count = 0
    str.chars.each_index { |i| count += 1 if str[i] == str[i+1] }
    count
end

# Test cases:
p duos('bootcamp')      # 1
p duos('wxxyzz')        # 2
p duos('hoooraay')      # 3
p duos('dinosaurs')     # 0
p duos('e')             # 0
puts

# Problem 2:
# Write a method sentence_swap that accepts a sentence and a hash as arguments.
# The method should return a new sentence where every word is replaced with 
# it's corresponding value in the hash. If a word does not exist 
# as a key of the hash, then it should remain unchanged.
def sentence_swap(sent, hsh)
    words = sent.split
    words.map do |word|
        word = hsh[word] if hsh[word]
        word
    end
    .join(" ")
end

# Test cases
p sentence_swap('anything you can do I can do',
    'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
) # 'nothing you shall drink I shall drink'

p sentence_swap('what a sad ad',
    'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
) # 'make a happy ad'

p sentence_swap('keep coding okay',
    'coding'=>'running', 'kay'=>'pen'
) # 'keep running okay'
puts

# Problem 3
# Write a method hash_mapped that accepts a hash, a proc, and a block. 
# The method should return a new hash where each key is the result of the 
# original key when given to the block. Each value of the new hash 
# should be the result of the original values when passed into the proc.
def hash_mapped(hsh, prc, &blc)
    new_hash = {}
    hsh.each { |k,v| new_hash[blc.call(k)] = prc.call(v) }
    new_hash
end

# Test cases:
double = Proc.new { |n| n * 2 }
p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

first = Proc.new { |a| a[0] }
p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# {25=>"q", 36=>"w"}
puts

# Problem 4
# Write a method counted_characters that accepts a string as an argument. 
# The method should return an array containing the characters of the string 
# that appeared more than twice. The characters in the output array should 
# appear in the same order they occur in the input string.
def counted_characters(str)
    hsh = Hash.new(0)
    str.each_char { |ch| hsh[ch] += 1 }
    hsh.keys.select { |k| hsh[k] > 2 }
end

# Test cases:
p counted_characters("that's alright folks") # ["t"]
p counted_characters("mississippi") # ["i", "s"]
p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
p counted_characters("runtime") # []
puts

# Problem 5:
# Write a method triplet_true? that accepts a string as an argument and 
# returns a boolean indicating whether or not the string contains three 
# of the same character consecutively.
def triplet_true?(str)
    str.chars.each_index do |i|
        return true if str[i] == str[i+1] && str[i] == str[i+2]
    end
    false
end

p triplet_true?('caaabb')        # true
p triplet_true?('terrrrrible')   # true
p triplet_true?('runninggg')     # true
p triplet_true?('bootcamp')      # false
p triplet_true?('e')             # false
puts

# Problem 6:
# Write a method energetic_encoding that accepts a string and a hash 
# as arguments. The method should return a new string where characters of 
# the original string are replaced with the corresponding values 
# in the hash. If a character is not a key of the hash, then it should be 
# replaced with a question mark ('?'). Space characters (' ') should remain 
# unchanged.
def energetic_encoding(str,hsh)
    str.chars.each_index do |i|
        if hsh[str[i]]
            str[i] = hsh[str[i]]
        else
            str[i] = "?" if str[i] != ' '
        end
    end
    str
end

# Test cases:
p energetic_encoding('sent sea',
    'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
) # 'zimp ziu'

p energetic_encoding('cat',
    'a'=>'o', 'c'=>'k'
) # 'ko?'

p energetic_encoding('hello world',
    'o'=>'i', 'l'=>'r', 'e'=>'a'
) # '?arri ?i?r?'

p energetic_encoding('bike', {}) # '????'
puts
        
# Problem 7:
# Write a method uncompress that accepts a string as an argument. 
# The string will be formatted so every letter is followed by a number. 
# The method should return an "uncompressed" version of the string where 
# every letter is repeated multiple times given based on the number that 
# appears directly after the letter.
def uncompress(str)
    new_str = ""
    chars = str.chars.select { |ch| ('a'..'z').include?(ch) }
    nums = str.chars.reject { |ch| ('a'..'z').include?(ch) }
    chars.each_index do |i|
        nums[i].to_i.times { new_str += chars[i] }
    end
    new_str
end

# Test cases:
p uncompress('a2b4c1') # 'aabbbbc'
p uncompress('b1o2t1') # 'boot'
p uncompress('x3y1x2z4') # 'xxxyxxzzzz'
puts

# ----Phase 2:----

# Problem 8:
# Write a method conjunct_select that accepts an array and one or more procs 
# as arguments. The method should return a new array containing the elements 
# that return true when passed into all of the given procs.
def conjunct_select(arr, *procs)
    arr.select do |el| 
        procs.all? { |prc| prc.call(el) }
    end
end

# Test cases:
is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]
puts

# Problem 9:
# Write a method convert_pig_latin that accepts a sentence as an argument. 
# The method should translate the sentence according to the following rules:
#
#     words that are shorter than 3 characters are unchanged
#     words that are 3 characters or longer are translated according to the 
#     following rules:
#         if the word begins with a vowel, simply add 'yay' to the end of 
#             the word (example: 'eat'->'eatyay')
#         if the word begins with a non-vowel, move all letters that 
#             come before the word's first vowel to the end of the word 
#             and add 'ay' (example: 'trash'->'ashtray')
#
# Note that if words are capitalized in the original sentence, they should 
# remain capitalized in the translated sentence. Vowels are the letters a, 
# e, i, o, u.
def convert_pig_latin(sent)
    words = sent.split
    words.map do |word|
        if word.length < 3
            word
        elsif "aeiouAEIOU".include?(word[0])
            word += "yay"
        else
            v = word.chars.select { |vowel| "aeiouAEIOU".include?(vowel)}[0]
            i = word.index(v)
            w = word[i..-1] + word[0].downcase + word[1...i] + "ay"
            w[0] = w[0].upcase if ('A'..'Z').include?(word[0])
            w
        end
    end
    .join(" ")
end

# Test cases:
p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"
puts

# Problem 10:
# Write a method reverberate that accepts a sentence as an argument. 
# The method should translate the sentence according to the following rules:
#
#     words that are shorter than 3 characters are unchanged
#     words that are 3 characters or longer are translated according to the 
#     following rules:
#         if the word ends with a vowel, simply repeat the word twice 
#             (example: 'like'->'likelike')
#         if the word ends with a non-vowel, repeat all letters that come 
#             after the word's last vowel, including the last vowel itself 
#             (example: 'trash'->'trashash')
#
# Note that if words are capitalized in the original sentence, 
# they should remain capitalized in the translated sentence. Vowels are the 
# letters a, e, i, o, u.
def reverberate(sent)
    words = sent.split
    words.map do |word|
        if word.length < 3
            word
        elsif "aeiouAEIOU".include?(word[-1])
            word += word
        else
            v = word.chars.select { |vowel| "aeiouAEIOU".include?(vowel)}[-1]
            i = word.index(v)
            w = word + word[i..-1]
            w[0] = w[0].upcase if ('A'..'Z').include?(word[0])
            w
        end
    end
    .join(" ")
end

# Test cases:
p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"
puts

# Problem 11:
# Write a method disjunct_select that accepts an array and one or more procs 
# as arguments. The method should return a new array containing the elements 
# that return true when passed into at least one of the given procs.
def disjunct_select(arr, *procs)
    arr.select do |el| 
        procs.any? { |prc| prc.call(el) }
    end
end

# Test cases:
longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
) # ["apple", "teeming"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o
) # ["dog", "apple", "teeming", "boot"]

p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
    longer_four,
    contains_o,
    starts_a
) # ["ace", "dog", "apple", "teeming", "boot"]
puts

# Problem 12:
# Write a method alternating_vowel that accepts a sentence as an argument. 
# The method should return a new sentence where the words alternate between 
# having their first or last vowel removed. For example:

#     the 1st word should be missing its first vowel
#     the 2nd word should be missing its last vowel
#     the 3rd word should be missing its first vowel
#     the 4th word should be missing its last vowel
#     ... and so on

# Note that words that contain no vowels should remain unchanged. 
# Vowels are the letters a, e, i, o, u.
def alternating_vowel(sent)
    words = sent.split
    words.map.with_index do |word,idx|
        if idx % 2 == 0
            first_vowel = word.chars.select { |ch| "aeiou".include?(ch) }[0]
            if first_vowel
                vowel_pos = word.index(first_vowel)
                word[0...vowel_pos] + word[vowel_pos + 1..-1]
            else
                word
            end
        else
            last_vowel = word.chars.reverse.select { |ch| "aeiou".include?(ch) }[0]
            if last_vowel
                vowel_pos = word.rindex(last_vowel)
                word[0...vowel_pos] + word[vowel_pos + 1..-1]
            else
                word
            end
        end
    end
    .join(" ")
end

# Test cases:

p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
p alternating_vowel('code properly please') # "cde proprly plase"
p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"
puts

# Problem 13:
# Write a method silly_talk that accepts a sentence as an argument. 
# The method should translate each word of the sentence according to the 
# following rules:

#     if the word ends with a vowel, simply repeat that vowel at the end of 
#         the word (example: 'code'->'codee')
#     if the word ends with a non-vowel, every vowel of the word should be 
#         followed by 'b' and that same vowel (example: 'siren'->'sibireben')

# Note that if words are capitalized in the original sentence, they should 
# remain capitalized in the translated sentence.
def silly_talk(sent)
    words = sent.split
    words.map do |word|
        if "aeiou".include?(word[-1])
            word += word[-1]
            word
        else
            silly_word = ""
            word.each_char.with_index do |ch,idx|
                "aeiou".include?(ch) ? silly_word += ch + "b" + ch : silly_word += ch
            end
            silly_word.capitalize! if ('A'..'Z').include?(word[0])
            silly_word
        end
    end
    .join(" ")
end

# Test cases:
p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
p silly_talk('They can code') # "Thebey caban codee"
p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"
puts

# Problem 14:
# Write a method compress that accepts a string as an argument. 
# The method should return a "compressed" version of the string where streaks 
# of consecutive letters are translated to a single appearance of the letter 
# followed by the number of times it appears in the streak. 
# If a letter does not form a streak (meaning that it appears alone), 
# then do not add a number after it.
def compress(str)
    return str if str == ""
    count = 0
    i = 0
    loop do
        if i == 0 || str[i] == str[i - 1]
            count += 1
            i += 1
        else
            break
        end
    end
    if count > 1
        compressed = str[i - 1] + count.to_s + compress(str[i..-1])
    else
        compressed = str[i - 1] + compress(str[i..-1])
    end
    compressed
end

# Test cases:
p compress('aabbbbc')   # "a2b4c"
p compress('boot')      # "bo2t"
p compress('xxxyxxzzzz')# "x3yx2z4"
puts
