# Recap Exercise 2 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/recap-exercise-2
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

require "byebug"

# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    min = [num_1,num_2].min
    max = [num_1,num_2].max

    (max..min*max).each do |i|
        return i if i % min == 0 && i % max == 0
    end

end

# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigram_count = Hash.new(0)
    bigrams = get_bigrams(str)
   
    bigrams.each do |ele|
        bigram_count[ele] += 1
    end
    bigram_count.keys.select { |key| bigram_count[key] == bigram_count.values.max }[0]
end

def get_bigrams(str)
    bigrams = []
    str.each_char.with_index do |c,idx|
        bigrams << str[idx..idx+1] if idx != str.length - 1
    end
    bigrams
end

    


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        new_h = {}
        self.each { |k,v| new_h[v] = k }
        new_h
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        arr = self.select { |ele| ele <= num }
       
        (0...arr.length - 1).each do |i|
            ((i + 1)...arr.length).each do |j|
                count += 1 if arr[i] + arr[j] == num
            end
        end
        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        prc ||= Proc.new { |a,b| a <=> b }
        sorted = false
        
        while !sorted do
            sorted = true
            (0...self.length - 1).each do |idx|
                if prc.call(self[idx],self[idx + 1]) == 1
                    self[idx], self[idx + 1] = self[idx + 1], self[idx]
                    sorted = false
                end
            end
        end
        
        self
    end
end
