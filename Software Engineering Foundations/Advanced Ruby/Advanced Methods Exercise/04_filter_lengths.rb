# Advanced Methods Exercise - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/advanced-methods-exercise
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Write a method, filter_lengths(strings, length), that accepts an array of strings
# and a length as args. The method should return an array containing the strings
# that have at least the given length. The length argument should be optional; if no length
# is passed in, then 5 should be used as the length.

def filter_lengths(arr,length = 5)
    return arr.select{ |el| el.length >= length }
end

p filter_lengths(["pear", "dragonfruit", "fig", "clementine"], 4)   # => ["pear", "dragonfruit", "clementine"]
p filter_lengths(["pear", "dragonfruit", "fig", "clementine"])      # => ["dragonfruit", "clementine"]
p filter_lengths(["cat", "dog", "capybara", "mouse"], 7)            # => ["capybara"]
p filter_lengths(["cat", "dog", "capybara", "mouse"])               # => ["capybara", "mouse"]
