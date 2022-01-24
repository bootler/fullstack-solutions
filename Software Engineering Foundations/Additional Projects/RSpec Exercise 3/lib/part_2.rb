# Alex Boutilier - RSpec Exercises 3
# Use 'bundle install' once, then 'bundle exec rspec' to run and test
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