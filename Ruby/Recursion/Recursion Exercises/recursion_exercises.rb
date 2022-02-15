# Recursion Exercises - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/recursion-exercises
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Warmup:
# Write a recursive method, range, that takes a start and an end and returns an array
#of all numbers in that range, exclusive. For example, range(1, 5) should return 
# [1, 2, 3, 4]. If end < start, you can return an empty array.
#
# Write both a recursive and iterative version of sum of an array.
def range(start, finish)
    return [] if finish <= start
    [start] + range((start + 1), finish)
end

def sum_array_rec(arr)
    return nil if arr.length < 1
    return arr[0] if arr.length == 1
    arr[0] + sum_array_rec(arr[1..-1])
end

def sum_array_iter(arr)
    sum = 0
    arr.each { |num| sum += num if num }
    sum
end

# Exercise 1:
# Write two versions of exponent that use two different recursions:
#
# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)
#
# recursion 2
# exp(b, 0) = 1
# exp(b, 1) = b
# exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
#
# Don't cheat and use exponentiation in your solution
def exp_1(base, n)
    return nil if n < 0
    return 1 if n == 0
    base * exp_1(base, n - 1)
end

def exp_2(base, n)
    return nil if n < 0
    return 1 if n == 0
    return base if n == 1
    e = n.even? ? exp_2(base, n / 2) : exp_2(base, (n - 1) / 2)
    return e * e if n.even?
    base * (e * e)
end

# Test cases
p exp_1(2, 256)
p exp_2(2, 256)
puts

# If the n == 256, about how many nested recursive steps will we run 
# in the first case?
#   => 256 
#   => Excluding the initial call, the recursive step is called
#      for the range (1..256)
#
# How deep will we need to recurse for the second? Keep in mind that the first 
# reduces the exponent by one for each recursion, while the second reduces it by 
# half.
#   => 8
#   => The answer is the amount of doubling needed from n = 2 to n = 256
#
# Example of written out process for exp_1(2, 5) => 32
#
# exp_1(2, 5)
# = 2 * exp_1(2, 4)
# = 2 * 2 * exp_1(2, 3)
# = 2 * 2 * 2 * exp_1(2, 2)
# = 2 * 2 * 2 * 2 * exp_1(2, 1)
# = 2 * 2 * 2 * 2 * 2 * exp_1(2, 0)
# = 2 * 2 * 2 * 2 * 2 * 1
# = 2 * 2 * 2 * 2 * 2
# = 2 * 2 * 2 * 4
# = 2 * 2 * 8
# = 2 * 16
# = 32
#
# Example of written out process for exp_2(2, 5)
# 
# exp_2(2, 7)
#   => e = exp_2(2, 3) => 2 * exp_2(2, 1) => 2 * 2
#   => e = 2 * 2 * 2
#   => e = 8
# = 2 * (8 * 8)
# = 2 * 64
# = 128

# Problem 2
# Using recursion and the is_a? method, write an Array#deep_dup method that will 
# perform a "deep" duplication of the interior arrays.
# (see exercise page linked above for more information.)
class Array
    def self.deep_dup(arr)
        dup = []
        arr.each do |ele|
            if ele.is_a?(Array)
                dup << deep_dup(ele)
            else
                dup << ele
            end
        end
        dup
    end
end

# Test cases: 
a = [2,3,4]
b = [1,a,[5, 6]]
c = Array.deep_dup(b)
p c                         # => [1, [2, 3, 4], [5, 6]]
a = [:x, :x, :x]            # => should not change c
p c                         # => [1, [2, 3, 4], [5, 6]]
puts

# Problem 3:
# Write a recursive and an iterative Fibonacci method.
# The method should take in an integer n and return the first n Fibonacci numbers 
# in an array.
# 
# You shouldn't have to pass any arrays between methods; 
# you should be able to do this just passing a single argument for the number of 
# Fibonacci numbers requested.
def fib(n)
    return nil if n < 1
    return [0] if n == 1
    return [0, 1] if n == 2
    nums = fib(n - 1)
    nums += [nums[-1] + nums[-2]]
    nums
end

def fib_iter(n)
    return nil if n < 1
    return [0] if n == 1
    arr = [0,1]
    (n - 2).times { arr << (arr[-1] + arr[-2]) }
    arr
end

# Test cases
p fib(5)            # => [0,1,1,2,3]
p fib_iter(5)       # => [0,1,1,2,3]
puts

# Problem 4:
# Write a recursive binary search: bsearch(array, target). 
# Note that binary search only works on sorted arrays. 
# Make sure to return the location of the found object (or nil if not found!). 
# Hint: you will probably want to use subarrays.
# NB: Please refer to the course page linked at the top of this file for more detailed information
def bsearch(arr, target)
    return nil unless arr
    return 0 if arr[0] == target
    return nil if arr.length <= 1

    len = arr.length.even? ? arr.length : arr.length + 1
    mid = (len / 2) - 1
    return mid if arr[mid] == target
    if target < mid
        pos = bsearch(arr[0...mid], target)
        if pos
            return mid - (mid - pos)
        else
            return pos
        end
    else
        pos = bsearch(arr[(mid + 1)..-1], target)
        if pos
            return mid + pos + 1
        else
            return pos
        end
    end
end

# Test cases
p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
puts

# Problem 5:
# Implement a method merge_sort that sorts an Array.
def merge_sort(arr)
    return arr if arr.length <= 1
    arr.length.even? ? len = arr.length / 2 : len = (arr.length + 1) / 2

     left = merge_sort(arr[0...len])
     right = merge_sort(arr[len..-1])

    merge(left, right)
end

def merge(left, right)
    arr = []
    until left.empty? || right.empty?
        if left[0] <= right[0]
            arr << left[0]
            left = left[1..-1]
        else
            arr << right[0]
            right = right[1..-1]
        end
    end

    until left.empty? do
        arr << left[0]
        left = left[1..-1]
    end

    until right.empty? do
        arr << right[0]
        right = right[1..-1]
    end
    arr
end

# Test cases:
p merge_sort([2,3,11,4,5,66,1,9])
p merge_sort([9,4,3,7,1,6,2,5])
puts

# Problem 6:
# Write a method subsets that will return all subsets of an array.
def subsets(arr)
    return [[]] if arr.empty?
    subs = subsets(arr[0...-1])
    (0...subs.length).each { |i| subs << subs[i] + [arr[-1]] }
    subs
end

# Test cases:
p subsets([1, 2, 3])
p subsets([1, 2, 3, 4])
puts

# Problem 7:
# Write a recursive method permutations(array) that calculates all the permutations 
# of the given array. For an array of length n there are n! different permutations.
def permutations(arr)
    return [arr] if arr.length <= 1
    perms = []
    (0...arr.length).each do |i|
        sub_perms = permutations(arr[1..-1])
        sub_perms.each { |el| perms << [arr[0]] + el }
        arr.rotate!
    end
    perms
end

p permutations([1,2,3])
p permutations([1,2,3,4]).length # => 24
puts

# Problem 8:
# The following problem 'Make Change' references an archived page
# from the following link: http://web.archive.org/web/20130215052843/http://rubyquiz.com/quiz154.html
# Full details of the problem can be found there.
# In a nutshell, the function takes an amount in cents and an optional array of coin
# denominations and returns an array of those coin denominations that consititute 
# exact change in the amount given
# e.g. make_change(39, [25,10,5,1]) => [25, 10, 1, 1, 1, 1]
#
# greedy_make_change is also called for. It is suboptimal.
def greedy_make_change(amt, coins=[25,10,5,1])
    return [] if amt <= 0
    change = []
    coins.each do |coin|
        if amt - coin >= 0
            change << coin
            change += greedy_make_change(amt - coin)
            return change
        end
    end
end

p greedy_make_change(39)
puts

# This implementation calls for finding the optimal amount of change
# e.g. fewest amount of coins used
def make_change(amt, coins=[25, 10, 5, 1])
    return [] if amt <= 0
    best = []
    coins.each.with_index do |coin, i|
        next if amt - coin < 0
        sub_change = make_change(amt - coin, coins[i..-1])
        if amt - sub_change.sum == coin
            best = [coin] + sub_change if best.empty? || sub_change.length + 1 < best.length
        end
    end
    best
end

p make_change(24, [10, 7, 1])
puts
        






