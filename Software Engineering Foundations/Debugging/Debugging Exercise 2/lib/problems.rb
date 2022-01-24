# Debugging Exercise 2 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/debugging-exercise-2
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.
require "byebug"

def largest_prime_factor(num)
    facs = get_factors(num)
    facs.reverse_each do |fac|
        return fac if prime?(fac)
    end
    nil
end

def prime?(num)
    return false if num < 2

    (2...num).each do |i|
        return false if num % i == 0
    end
    return true
end

def get_factors(num)
    arr = []
    (1..num).each do |i|
        arr << i if num % i == 0
    end
    arr
end

def unique_chars?(str)
    hash = Hash.new(0)
    str.each_char do |ch|
        hash[ch] += 1
    end

    hash.each_value do |v|
        return false if v > 1
    end
    return true
end

def dupe_indices(arr)
    #debugger
    hash = Hash.new { [] }

    arr.each.with_index do |el,idx|
        hash[el] = hash[el].push(idx) if arr.any? { |val| val == el } && !(arr.one? { |val| val == el })     
    end

    return hash
end

def ana_array(arr1,arr2)
    return false if arr1.length != arr2.length
    arr1.each do |el|
        return false if !(arr2.any? { |e| e == el })
    end
    arr2.each do |el|
        return false if !(arr1.any? { |e| e == el })
    end
    return true
end
