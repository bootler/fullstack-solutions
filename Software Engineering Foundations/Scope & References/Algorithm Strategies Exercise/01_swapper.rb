# Algorithmic Strategies Exercise - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/algorithmic-strategies-exercise
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Write a method, swapper(arr, idx_1, idx_2), that accepts an array and two indices as args.
# The method should swap the elements at the given indices and return the array.
# The method should modify the existing array and not create a new array.

def swapper(arr,idx1,idx2)
    arr[idx1], arr[idx2] = arr[idx2], arr[idx1]
    return arr
end

p swapper(["a", "b", "c", "d"], 0, 2)               # => ["c", "b", "a", "d"]
p swapper(["a", "b", "c", "d"], 3, 1)               # => ["a", "d", "c", "b"]
p swapper(["canal", "broadway", "madison"], 1, 0)   # => ["broadway", "canal", "madison"]
