# Debugging Exercise 1 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/debugging-exercise-1
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Debug this code to pass rspec! There is 1 mistake to fix.

# Write a method, fuzz_buzz, that accepts a number as an arg. 
# The method should return an array of numbers from one to the given number that are not divisible by 3 or 5.

require "byebug"

def fuzz_buzz(num)
    numbers = []

    (1..num).each do |i|
        if !(i % 3 == 0 || i % 5 == 0)
            numbers << i
        end
    end

    numbers
end