# Advanced Methods Exercise - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/advanced-methods-exercise
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Write a method, multi_dimensional_sum(array), that accepts a multidimensional array as an arg 
# and returns the sum of all numbers in the array.

def multi_dimensional_sum(arr)
    return arr.flatten.sum
end

arr_1 = [
    [4, 3, 1],
    [8, 1],
    [2]
]

p multi_dimensional_sum(arr_1)    # => 19

arr_2 = [
    [ [3, 6], [7] ],
    [ [5, 2], 1 ]
]

p multi_dimensional_sum(arr_2)    # => 24
