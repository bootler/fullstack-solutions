# Problem descriptions and test cases provided by course.

# Problem 1:
# Write a method no_dupes?(arr) that accepts an array as an arg 
# and returns a new array containing the elements that were not 
# repeated in the array.

def no_dupes?(arr)
    arr.select { |ele| arr.one?(ele) }
end

# Test cases
p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []
puts

# Problem 2:
# Write a method no_consecutive_repeats?(arr) that accepts 
# an array as an arg. The method should return true if an 
# element never appears consecutively in the array; 
# it should return false otherwise.

def no_consecutive_repeats?(arr)
    arr.inject do |acc,el|
        return false if acc == el
        acc = el
    end
    return true
end

# Test cases
p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true
puts

# Problem 3:
# Write a method char_indices(str) that takes in a string as an arg. 
# The method should return a hash containing characters as keys. 
# The value associated with each key should be an array containing the indices 
# where that character is found.

def char_indices(str)
    char_idx_hash = Hash.new { |h,k| h[k] = [] }
    str.each_char.with_index { |ch,idx| char_idx_hash[ch] << idx }
    char_idx_hash
end

# Test cases
p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}
puts

# Problem 4:
# Write a method longest_streak(str) that accepts a string as an arg. 
# The method should return the longest streak of consecutive characters 
# in the string. If there are any ties, return the streak that occurs later 
# in the string.

def longest_streak(str)
    longest = ""
    cur_streak = ""
    cur_char = ''
    str.each_char do |ch|
        cur_char == ch ? cur_streak += ch : cur_streak = ch
        longest = cur_streak if cur_streak.length >= longest.length
        cur_char = ch
    end
    longest
end

# Test cases
p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'
puts

# Problem 5:
# Write a method bi_prime?(num) that accepts a number as an arg and returns 
# a boolean indicating whether or not the number is a bi-prime. 
# A bi-prime is a positive integer that can be obtained by multiplying 
# two prime numbers.

def bi_prime?(num)
    return false if is_prime?(num)
    prime_facs = (2...num).select { |i| is_prime?(i) && num % i == 0 }
    prime_facs.each { |fac| return true if is_prime?(num / fac) }
    false
end

# Helper method 5a: Determine if a number is prime
# Useful for the number we're checking as well as its factors

def is_prime?(num)
    return false if num < 2
    return true if num == 2
    (3...num).each { |i| return false if num % i == 0 }
    true
end

# Test cases
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false
puts

# Problem 6:
# Write a method vigenere_cipher(message, keys) that accepts a string and a 
# key-sequence as args, returning the encrypted message. Assume that the 
# message consists of only lowercase alphabetic characters.

# Note: A caesar cipher offsets each letter of the message by a single key value
# e.g. caesar(abc,3) => def. A vigenere cipher does the same with a sequence of keys,
# offsetting each letter by the current key in the sequence.
# The sequence repeats over the length of the message.
# e.g. vigenere(banana, [1,2]) => ccococ

def vigenere_cipher(message,keys)
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    encrypted = ""
    message.each_char.with_index do |ch,idx|
        encrypted += alphabet[(alphabet.index(ch) + keys[idx % keys.length]) % 26]
    end
    encrypted
end

# Test cases
p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"
puts

# Problem 7:
# Write a method vowel_rotate(str) that accepts a string as an arg 
# and returns the string where every vowel is replaced with the vowel that 
# appears before it sequentially in the original string. 
# The first vowel of the string should be replaced with the last vowel.

def vowel_rotate(str)
    vowels = str.chars.select { |ch| "aeiou".include?(ch) }
    vowels.rotate!(-1)
    r_count = 0
    (0...str.length).each do |pos|
        if "aeiou".include?(str[pos])
            str[pos] = vowels[r_count]
            r_count += 1
        end
    end
    str
end

# Test cases
p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"
puts

# Note: Problems 8-9 require extending the same class
# Therefore the extended String class below contains the solutions for 8-9

# Problem 8:
# Extend the string class by defining a String#select method that accepts a 
# block. The method should return a new string containing characters of the 
# original string that return true when passed into the block. 
# If no block is passed, then return the empty string. 
# Do not use the built-in Array#select in your solution.

# Problem 9:
# Extend the string class by defining a String#map! method that accepts a 
# block. The method should modify the existing string by replacing every 
# character with the result of calling the block, passing in the original 
# character and it's index. Do not use the built-in Array#map or Array#map! 
# in your solution.

class String
    def select(&prc)
        str = ""
        return str if !prc
        self.each_char { |ch| str += ch if prc.call(ch) }
        str
    end

    def map!(&prc)
        (0...self.length).each { |i| self[i] = prc.call(self[i],i) }
    end
end

# Test cases - 8
p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
p "HELLOworld".select          # => ""
puts

# Test cases - 9
word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"
puts

# Problem 10:
# Write a method multiply(a, b) that takes in two numbers and returns their product.

#     You must solve this recursively (no loops!)
#     You must not use the multiplication (*) operator

def multiply(a,b)
    return 0 if b == 0
    b > 0 ? a + multiply(a, b - 1) : -(a + multiply(a,-b - 1))
end

# Test cases
p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18
puts

# Problem 11:
# Write a method lucasSequence that accepts a number representing a length 
# as an arg. The method should return an array containing the Lucas Sequence 
# up to the given length. Solve this recursively.
#
# Note: Lucas sequence = [2,1,lucas(n-1) + lucas(n-2)...] 
# Similar to the Fibonacci sequence.

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2,1] if length == 2

    seq = lucas_sequence(length - 1)
    cur_el = seq[-1] + seq[-2]
    seq << cur_el
    seq
end

# Test cases
p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]
puts

# Problem 12:
# Write a method prime_factorization(num) that accepts a number and returns 
# an array representing the prime factorization of the given number. 
# This means that the array should contain only prime numbers that multiply 
# together to the given num. The array returned should contain numbers in 
# ascending order. Do this recursively.
#
# Note: See Helper Method 5a from Problem 5 for definition of is_prime?
def prime_factorization(num)
    return [] if num < 2
    return [num] if is_prime?(num)
    fact = 0

    (2...num).each do |i|
        if num % i == 0
            fact = i
            break
        end
    end
    
    prime_factorization(fact) + prime_factorization(num / fact)
end

# Test cases
p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]
puts
