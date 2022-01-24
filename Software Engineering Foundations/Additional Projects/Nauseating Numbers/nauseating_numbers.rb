# App Academy Open - Software Engineering Foundations
# Advanced Problem Set 1: 'Nauseating Numerals'
# Problem descriptions and test cases provided by course
# Solutions by Alex Boutilier
require('byebug')

# ----Phase 1:----

# Problem 1:
# Write a method strange_sums that accepts an array of numbers as an argument. 
# The method should return a count of the number of distinct pairs of elements 
# that have a sum of zero. You may assume that the input array contains 
# unique elements.

def strange_sums(arr)
    count = 0
    arr.each.with_index do |el,idx| 
        count += 1 if arr[idx..-1].one? { |match| el + match == 0 }
    end
    count
end

# Test cases
p strange_sums([2, -3, 3, 4, -2])     # 2
p strange_sums([42, 3, -1, -42])      # 1
p strange_sums([-5, 5])               # 1
p strange_sums([19, 6, -3, -20])      # 0
p strange_sums([9])                   # 0
puts

# Problem 2:
# Write a method pair_product that accepts an array of numbers and a 
# product as arguments. The method should return a boolean indicating 
# whether or not a pair of distinct elements in the array result in the 
# product when multiplied together. You may assume that the input array 
# contains unique elements.

def pair_product(arr,prod)
    arr.any? do |el|
        arr.any? { |match| match != el && el * match == prod }
    end
end

# Test cases
p pair_product([4, 2, 5, 8], 16)    # true
p pair_product([8, 1, 9, 3], 8)     # true
p pair_product([3, 4], 12)          # true
p pair_product([3, 4, 6, 2, 5], 12) # true
p pair_product([4, 2, 5, 7], 16)    # false
p pair_product([8, 4, 9, 3], 8)     # false
p pair_product([3], 12)             # false
puts

# Problem 3:
# Write a method rampant_repeats that accepts a string and a hash as arguments. 
# The method should return a new string where characters of the original 
# string are repeated the number of times specified by the hash. 
# If a character does not exist as a key of the hash, then it should remain 
# unchanged.

def rampant_repeats(str,hsh)
    subs = []
    hsh.each do |k,v|
        # the tricky part is that the matching indices change depending on previous insertions
        # using a control var to count previous insertions helps us to calculate the correct index each time
        ctrl = 0   
        str.each_char.with_index do |ch,idx|
            if ch == k
                rpt = ""
                len = v - 1
                len.times { rpt += ch }
                str.insert(idx + (len * ctrl), rpt) # here ctrl is used to figure out where the new index will be if it was changed by previous repeats
                ctrl += 1
            end
        end
    end
    str
end

# Test cases
p rampant_repeats('taco', {'a'=>3, 'c'=>2})             # 'taaacco'
p rampant_repeats('feverish', {'e'=>2, 'f'=>4, 's'=>3}) # 'ffffeeveerisssh'
p rampant_repeats('misispi', {'s'=>2, 'p'=>2})          # 'mississppi'
p rampant_repeats('faarm', {'e'=>3, 'a'=>2})            # 'faaaarm'
puts

# Problem 4:
# Write a method perfect_square? that accepts a number as an argument. 
# The method should return a boolean indicating whether or not the argument 
# is a perfect square. A perfect square is a number that is the product of 
# some number multiplied by itself. For example, since 64 = 8 * 8 and 
# 144 = 12 * 12, 64 and 144 are perfect squares; 35 is not a perfect square.

def perfect_square?(num)
    Math.sqrt(num) % 1 == 0
end

# Test cases
p perfect_square?(4)     # true
p perfect_square?(64)    # true
p perfect_square?(100)   # true
p perfect_square?(169)   # true
p perfect_square?(2)     # false
p perfect_square?(40)    # false
p perfect_square?(32)    # false
p perfect_square?(50)    # false
p perfect_square?(1)     # true
puts

# ----Phase 2:----

# Problem 5:
# Write a method anti_prime? that accepts a number as an argument. 
# The method should return true if the given number has more divisors than 
# all positive numbers less than the given number. For example, 24 is an 
# anti-prime because it has more divisors than any positive number 
# less than 24.

# The efficiency of this method can be increased by observing the prime factorization 
# of anti-primes, which always take the form: (x^a)(y^b)(z^c)... where:
#   * (x), (y), (z) are base primes and x < y < z...
#   * (a), (b), (c) are exponents and a >= b >= c...
# e.g (2^2)(3)(5) = 60 which is anti-prime (1,2,3,4,5,6,10,12,15,20,30,60)
#
# Per the above, for any (x) >= 12 and (x) is anti-prime:
#   * The prime factorization of (x) contains (2^2)(3)
#   * x % 12 == 0
# 
# Therefore only multiples of 12 need to be considered when num >= 12
# and only lower multiples of 12 need to be factored for comparison
#
# This solution employs recursive combination of prime factors to avoid
# trial-division, making it feasible for larger numbers. However, a far simpler
# trial-division implementation would have been within the scope of the exercise.
def anti_prime?(num)
    return true if num == 1
    return false if num > 12 && num % 12 != 0

    count = num > 12 ? num - 12 : num - 1
    
    # These assignments provide the total factor count for num
    num_prime_facs = pf(num)
    num_base_primes = pf_sort(num_prime_facs).keys
    num_prime_expts = pf_sort(num_prime_facs).values
    num_facs = all_factors(num_base_primes, num_prime_expts).length
    
    while count > 1
        # factor count for the current lower integer being tested against num
        count_prime_facs = pf(count)
        count_base_primes = pf_sort(count_prime_facs).keys
        count_prime_expts = pf_sort(count_prime_facs).values
        count_facs = all_factors(count_base_primes, count_prime_expts).length
        
        return false if count_facs >= num_facs
        
        count >= 12 ? count -= 12 : count -= 1 
    end
    true
end

# Helper method 5a: is_prime?(num) returns a boolean indicating if num is prime
# is_prime?(11) => true
def is_prime?(num)
    return false if num < 2
    (2...num).none? { |i| num % i == 0 }
end

# Helper method 5b: pf(num) returns an array containing 
# the prime factorization of num - a positive integer
# pf(12) => [2,2,3]
def pf(num)
    return [] if num < 2
    return [num] if is_prime?(num)

    fact = 0
    (2...num).each do |i|
        if num % i == 0
            fact = i
            break
        end
    end
    pf(fact) + pf(num / fact)
end

# Helper method 5c: pf_sort returns a hash containing the base prime 
# and exponent pairs of a prime factorization
# pf_sort([2,2,3,5]) => {2:2,3:1,5:1}
# pf_sort([2,2,3,5]).keys => [2,3,5]
# pf_sort([2,2,3,5]).values => [2,1,1]
def pf_sort(p_facs)
    hsh = Hash.new(0)
    p_facs.each { |el| hsh[el] += 1 }
    hsh
end

# Helper method 5d: all_factors: Takes the base primes and the exponents
# of a number's prime factorization and returns all factors of that number
# all_factors([2,3,5],[2,1,1]) => [1,2,3,4,5,6,10,12,15,20,30,60]
#
# The point of the other helper methods is to derive the non-default args
# to this method from our test numbers so that we can test them for 
# being anti-prime without trial division. 
#
# params: 
#   prime facs => an array of non-duplicate prime factors
#   exponents => an array of the exponent of the index-matching factor
#   cur_div => the index of the current prime being multiplied
#   cur_fac => the current factor produced by the iteration
#   out_arr => an array containing all factors of the number      
def all_factors(prime_facs, exponents, cur_div=0, cur_fac=1,out_arr=[])
    if cur_div == prime_facs.length
        out_arr << cur_fac
        return
    end
    (0..exponents[cur_div]).each do |i|
        all_factors(prime_facs, exponents, cur_div + 1, cur_fac,out_arr)
        cur_fac *= prime_facs[cur_div]
    end
    out_arr
end
                
# Test cases
p anti_prime?(24)   # true
p anti_prime?(36)   # true
p anti_prime?(48)   # true
p anti_prime?(360)  # true
p anti_prime?(1260) # true
p anti_prime?(27)   # false
p anti_prime?(5)    # false
p anti_prime?(100)  # false
p anti_prime?(136)  # false
p anti_prime?(1024) # false
# Tests for a large anti prime if uncommented. Takes 2 minutes
# p anti_prime?(1441440) # true
puts

# Problem 6:
# Let a 2-dimensional array be known as a "matrix". Write a method matrix_addition that accepts 
# two matrices as arguments. The two matrices are guaranteed to have the same "height" and 
# "width". The method should return a new matrix representing the sum of the two arguments. 
# To add matrices, we simply add the values at the same positions
def matrix_addition(mat_a,mat_b)
    mat_a.each.with_index do |arr,i|
        arr.each_index { |j| arr[j] += mat_b[i][j] }
    end
    mat_a
end

# Test cases:
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

p matrix_addition(matrix_a, matrix_b) # [[11, 6], [7, 7]]
p matrix_addition(matrix_a, matrix_c) # [[1, 5], [4, 6]]
p matrix_addition(matrix_b, matrix_c) # [[8, 1], [3, -1]]
p matrix_addition(matrix_d, matrix_e) # [[2, -5], [19, 14], [6, 4]]
puts

# Problem 7:
# Write a method mutual_factors that accepts any amount of numbers as arguments. 
# The method should return an array containing all of the common divisors shared among the 
# arguments. For example, the common divisors of 50 and 30 are 1, 2, 5, 10. 
# You can assume that all of the arguments are positive integers.
#
# Note: We could re-use the factoring method from problem 5 but to keep the solutions self-contained
# we will re-implement a simpler factoring method
def mutual_factors(*nums)
    facs = nums.map { |num| get_factors(num) }
    facs[0].select do |el|
        facs.all? do |arr|
            arr.any? { |num| num == el }
        end
    end
end

# Helper method 7a: get_factors: return all factors of a number through simple trial-division
def get_factors(num)
    (1..num).select { |i| num % i == 0 }
end

# Test cases:
p mutual_factors(50, 30)            # [1, 2, 5, 10]
p mutual_factors(50, 30, 45, 105)   # [1, 5]
p mutual_factors(8, 4)              # [1, 2, 4]
p mutual_factors(8, 4, 10)          # [1, 2]
p mutual_factors(12, 24)            # [1, 2, 3, 4, 6, 12]
p mutual_factors(12, 24, 64)        # [1, 2, 4]
p mutual_factors(22, 44)            # [1, 2, 11, 22]
p mutual_factors(22, 44, 11)        # [1, 11]
p mutual_factors(7)                 # [1, 7]
p mutual_factors(7, 9)              # [1]
puts

# Problem 8:
# Write a method tribonacci_number that accepts a number argument, n, and returns the n-th number 
# of the tribonacci sequence.
#
# Note: The tribonacci sequence is like fibonacci except the first 3 numbers are 1,1,2 and
# every subequent number is the sum of the previous 3 numbers
def tribonacci_number(n)
    return 1 if n < 3
    return 2 if n == 3

    return tribonacci_number(n - 1) + tribonacci_number(n - 2) + tribonacci_number(n - 3)
end

# Test cases:
p tribonacci_number(1)  # 1
p tribonacci_number(2)  # 1
p tribonacci_number(3)  # 2
p tribonacci_number(4)  # 4
p tribonacci_number(5)  # 7
p tribonacci_number(6)  # 13
p tribonacci_number(7)  # 24
p tribonacci_number(11) # 274
puts

# ----Phase 3:----

# Problem 9: 
# Write a method matrix_addition_reloaded that accepts any number of matrices as arguments. 
# The method should return a new matrix representing the sum of the arguments. 
# Matrix addition can only be performed on matrices of similar dimensions, 
# so if all of the given matrices do not have the same "height" and "width", then return nil.
def matrix_addition_reloaded(*mats)
    return nil if mats.any? { |mat| mat.length != mats[0].length }
    mats.each do |mat|
        return nil if mat.any? { |arr| arr.length != mats[0][0].length }
    end

    mats[0].each.with_index do |arr,i|
        arr.each_index do |j|
            (1...mats.length).each do |k|
                arr[j] += mats[k][i][j] # geez...
            end
        end
    end
    mats[0]
end

# Test cases:
matrix_a = [[2,5], [4,7]]
matrix_b = [[9,1], [3,0]]
matrix_c = [[-1,0], [0,-1]]
matrix_d = [[2, -5], [7, 10], [0, 1]]
matrix_e = [[0 , 0], [12, 4], [6,  3]]

p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil
puts

# Problem 10:
# Write a method squarocol? that accepts a 2-dimensional array as an argument. 
# The method should return a boolean indicating whether or not any row or column is completely 
# filled with the same element. You may assume that the 2-dimensional array has "square" dimensions, 
# meaning it's height is the same as it's width.
def squarocol?(matrix)
    matrix.each.with_index do |arr,i|
        return true if arr.all? { |el| el == arr[0] }
        return true if matrix.all? { |col| col[i] == arr[i] }
    end
    false
end

# Test cases: 
p squarocol?([
    [:a, :x , :d],
    [:b, :x , :e],
    [:c, :x , :f],
]) # true

p squarocol?([
    [:x, :y, :x],
    [:x, :z, :x],
    [:o, :o, :o],
]) # true

p squarocol?([
    [:o, :x , :o],
    [:x, :o , :x],
    [:o, :x , :o],
]) # false

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 7],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # true

p squarocol?([
    [1, 2, 2, 7],
    [1, 6, 6, 0],
    [0, 5, 2, 7],
    [4, 2, 9, 7],
]) # false
puts

# Problem 11:
# Write a method squaragonal? that accepts 2-dimensional array as an argument. 
# The method should return a boolean indicating whether or not the array contains all of the same 
# element across either of its diagonals. You may assume that the 2-dimensional array has 
# "square" dimensions, meaning it's height is the same as it's width.
def squaragonal?(matrix)
    (0...matrix.length - 1).each do |i|
        return false if matrix[i][i] != matrix[i+1][i+1] && 
            matrix[-1 - i][i] != matrix[-1 - (i + 1)][i+1]
    end
    true
end

# Test cases:
p squaragonal?([
    [:x, :y, :o],
    [:x, :x, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [:x, :y, :o],
    [:x, :o, :x],
    [:o, :o, :x],
]) # true

p squaragonal?([
    [1, 2, 2, 7],
    [1, 1, 6, 7],
    [0, 5, 1, 7],
    [4, 2, 9, 1],
]) # true

p squaragonal?([
    [1, 2, 2, 5],
    [1, 6, 5, 0],
    [0, 2, 2, 7],
    [5, 2, 9, 7],
]) # false
puts

# Problem 12: 
# Write a method pascals_triangle that accepts a positive number, n,
# as an argument and returns a 2-dimensional array representing the first n levels of 
# pascal's triangle.

# generate n levels of pascal's triangle
def pascals_triangle(n)
    return [[1]] if n == 1
    
    triangle = pascals_triangle(n - 1)
    prev_level = triangle[-1]
    next_level = [1]
    
    (1...n - 1).each { |i| next_level << prev_level[i - 1] + prev_level[i] }
    next_level << 1
    triangle << next_level
    
    triangle
end

# Test cases: (Revised from exercise for cleaner formatting)
pascals_triangle(7).each { |level| p level }
puts
pascals_triangle(10).each { |level| p level }
puts

# ----Phase 4:----

# Problem 13: 
# Write a method mersenne_prime that accepts a number, n, as an argument and returns the 
# n-th Mersenne prime.
#
# Note: A Mersenne prime is a prime (p) that also satisfies the equation 2^x - 1 = p
# Note: See "Helper metod 5a" for definition of is_prime?
def mersenne_prime(n)
    count = 0
    x = 1
    while count < n
        num = 2**x - 1
        count += 1 if is_prime?(num)
        x += 1
    end
    num
end

# Test cases:
p mersenne_prime(1) # 3
p mersenne_prime(2) # 7
p mersenne_prime(3) # 31
p mersenne_prime(4) # 127
p mersenne_prime(6) # 131071
puts

# Problem 14:
# Write a method triangular_word? that accepts a word as an argument and 
# returns a boolean indicating whether or not that word's number encoding is a triangular number. 
# You can assume that the argument contains lowercase letters.
#
# Note: A word's number encoding is the sum of the value of it's letters
# based on their position in the alphabet. e.g. a = 1, b = 2, "aba" => 4
#
# Note: A triangular number (n) satisfies: n = (i * (i+1)) / 2
# where (i) is some positive integer.
def triangular_word?(word)
    num_enc = num_encode(word)
    triangle_seq(num_enc).any? { |num| num == num_enc }
end

# Helper method 14a: num_encode returns the numeric value of the word
# according to the above spec
def num_encode(word)
    alphabet = ('a'..'z').to_a
    word.chars.inject(0) { |acc,char| acc += alphabet.index(char) + 1 }
end

# Helper method 14b: triangle_seq returns the first (n) triangular numbers
def triangle_seq(n)
    seq = []
    (1..n).each { |i| seq << (i * (i+1)) / 2 }
    seq
end

p triangular_word?('abc')       # true
p triangular_word?('ba')        # true
p triangular_word?('lovely')    # true
p triangular_word?('question')  # true
p triangular_word?('aa')        # false
p triangular_word?('cd')        # false
p triangular_word?('cat')       # false
p triangular_word?('sink')      # false
puts

# Problem 15: 
# Write a method consecutive_collapse that accepts an array of numbers as an argument. 
# The method should return a new array that results from continuously removing consecutive numbers 
# that are adjacent in the array. If multiple adjacent pairs are consecutive numbers, 
# remove the leftmost pair first.
def consecutive_collapse(arr)
    done = false
    while !done
        done = true
        arr.each_index do |i|
            if arr[i] + 1 == arr[i+1] || arr[i] - 1 == arr[i+1]
                arr = arr[0...i] + arr[i+2..-1]
                done = false
                break
            end
        end
    end
    arr
end

# Test cases:
p consecutive_collapse([3, 4, 1])                     # [1]
p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
p consecutive_collapse([9, 8, 2])                     # [2]
p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
p consecutive_collapse([13, 11, 12, 12])              # []
puts

# Problem 16:
# Write a method pretentious_primes that takes accepts an array 
# and a number, n, as arguments. The method should return a new array 
# where each element of the original array is replaced according to the 
# following rules:
#
#     when the number argument is positive, replace an element 
#         with the n-th nearest prime number that is greater than the element
#     when the number argument is negative, replace an element 
#         with the n-th nearest prime number that is less than the element
#
# If there are fewer than (n) lower primes, return nil for that element
def pretentious_primes(arr,n)
     arr.map do |el|
        if n < 0
            get_primes(el)[-1 + (n + 1)]
        else
            get_primes(el,n)[-1]
        end
    end
end

# Helper method 16a: get_primes(num,n) retrns all primes 
# up to and including num if applicable.
# if n is a positive integer, additionally return the next (n) primes
# that are greater than num
#
# Note: See Helper method 5a for definition of is_prime?
def get_primes(num,n=0)
    primes = []
    (2...num).each { |i| primes << i if is_prime?(i) }
    while n > 0
        num += 1
        if is_prime?(num)
            primes << num
            n -= 1
        end
    end
    primes
end

# Test cases:
p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]
puts
