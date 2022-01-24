# Enumerable Exercises - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/enumerables
# NB: This file specifically implements the methods under 'Review' section.
# Solutions by: Alex Boutilier

# Problem 1:
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.
def factors(num)
    facs = [1]
    if !is_prime?(num)
        (2...num).each { |fac| facs << fac if num % fac == 0 }
    end
    facs << num
    facs
end

# Helper method 1a: is_prime?(num) returns true if num is prime, otherwise false.
def is_prime?(num)
    return false if num < 2
    (2...num).none? { |n| num % n == 0 }
end

# Note: The next problems require extending the Array class.
class Array

    # Problem 2:
    # Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
    # modify the array so that it is in sorted order.
    def bubble_sort!
        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |i|
                if self[i + 1] < self[i]
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false
                end
            end
        end
    end

    # Problem 3:
    # After writing `bubble_sort!`, write a `bubble_sort` that does the same
    # but doesn't modify the original. Do this in two lines using `dup`.
    def bubble_sort
        arr = self.dup
        arr.bubble_sort!
    end

    # Problem 4:
    # Finally, modify your `Array#bubble_sort!` method so that, instead of
    # using `>` and `<` to compare elements, it takes a block to perform the
    # comparison:
    def bubble_sort!(&prc)
        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |i|
                if prc.call(self[i], self[i + 1]) == 1
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false
                end
            end
        end
    end
end

# Problem 5:
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
def substrings(str)
    return [] if str.length < 1
    return [str] if str.length == 1
    subs = []
    str.chars.each_index { |i| subs << str[0..i] }
    subs += substrings(str[1..-1])
    subs.uniq!
    subs
end

# Problem 6:
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).
def subwords(str, dictionary)
    substrings(str).select { |word| dictionary.include?(word) }
end



