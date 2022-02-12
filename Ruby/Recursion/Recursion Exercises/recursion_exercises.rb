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
    $c += 1
    return nil if n < 0
    return 1 if n == 0
    return base if n == 1
    e = exp_2(base, n / 2)
    o = exp_2(base, (n - 1) / 2)
    return e * e if n.even?
    base * (o * o)
end

# If the n == 256, about how many nested recursive steps will we run 
# in the first case?
#   => 256 
#   => Excluding the initial 