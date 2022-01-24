# Debugging Exercise 1 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/debugging-exercise-1
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Debug this code to pass rspec! There are 1 mistake to fix.

# Write a method, half_and_double, that accepts an array of numbers as an arg. 
# The method should return a new array where every even number is divided by 2 and every odd
# number is multipled by 2.

require "byebug"

def half_and_double(array)
    new_array = array.map do |num|
        if num % 2 == 0
            num / 2
        else
            num * 2
        end
    end

    new_array
end