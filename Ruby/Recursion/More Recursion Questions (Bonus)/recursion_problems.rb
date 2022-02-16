# More Recursion Questions (Bonus) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/more-recursion-questions--bonus-
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Problem 1: 
# Write a function that sums the elements of an array recursively
def sum_recur(array)
    return 0 if array.empty?
    array[0] + sum_recur(array[1..-1])
end

# Problem 2: 
# Write a recursive function to determine whether or not the 
# given array contains the specified value
def includes?(array, target)
    return false if array.empty?
    return true if array.shift == target
    includes?(array, target)
end

# Problem 3: 
# Write a recursive function to count the number of occurences 
# of a specific value.
def num_occur(array, target)
    return 0 if array.empty?
    count = 0
    count += 1 if array.shift == target
    count += num_occur(array, target)
    count
end

# Problem 4: 
# Write a recursive function to determine whether or not any two adjacent elements
# of the array add to twelve
def add_to_twelve?(array)
    return false if array.empty? || !array[1]
    return true if array[0] + array[1] == 12
    add_to_twelve?(array[1..-1])
end

# Problem 5: 
# Write a recursive function to determine if an array is sorted
def sorted?(array)
    return true if array.length <= 2
    (array[0] <=> array[1]) == (array[1] <=> array[2]) && sorted?(array[2..-1])
end

# Problem 6: 
# Write a recursive function to reverse a string
def reverse(string)
    return string if string.length <= 1
    string[-1] + reverse(string[0...-1])
end