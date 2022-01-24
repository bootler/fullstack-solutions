# RSpec Exercise 3 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/rspec-exercise-3
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require('byebug')

def element_count(arr)
    count_hash = Hash.new(0)
    arr.each { |el| count_hash[el] += 1 }
    count_hash
end

def char_replace!(str,char_hash)
    (0...str.length).each { |i| str[i] = char_hash[str[i]] if char_hash.keys.include?(str[i]) }
    str
end

def product_inject(arr)
    arr.inject { |acc,el| acc *= el }
end