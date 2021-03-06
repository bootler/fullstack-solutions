# Algorithmic Strategies Exercise - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/algorithmic-strategies-exercise
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Write a method, peak_finder(arr), that accepts an array of numbers as an arg.
# The method should return an array containing all of "peaks" of the array.
# An element is considered a "peak" if it is greater than both it's left and right neighbor.
# The first or last element of the array is considered a "peak" if it is greater than it's one neighbor.

def peak_finder(arr)
    peak_flag = false
    newArr = []
    arr.inject(0) do |acc,ele|
        peak_flag = true if ele > acc
        if peak_flag && ele < acc 
            newArr << acc
            peak_flag = false
        end
        ele
    end
    newArr << arr[-1] if arr[-1] > arr[-2]
    return newArr
end

p peak_finder([1, 3, 5, 4])         # => [5]
p peak_finder([4, 2, 3, 6, 10])     # => [4, 10]
p peak_finder([4, 2, 11, 6, 10])    # => [4, 11, 10]
p peak_finder([1, 3])               # => [3]
p peak_finder([3, 1])               # => [3]
