# Debugging Exercise 1 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/debugging-exercise-1
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Debug this code to pass rspec! There are 2 mistakes to fix.

# Write a method, prime?, that accepts a number. It should return a boolean indicating whether or not the given number 
# is a prime. A prime number is only divisible by 1 and itself, it should have no other divisors.

require "byebug"

def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        if num % factor == 0
            return false
        end
    end
    return true
end