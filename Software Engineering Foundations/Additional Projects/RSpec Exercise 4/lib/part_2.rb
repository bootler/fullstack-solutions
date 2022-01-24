# Alex Boutilier - RSpec Exercises 4
# Verify RSpec installation with 'bundle install' then use 'bundle exec rspec'
require('byebug')

def proper_factors(num)
    (1...num).select { |fact| num % fact == 0 }
end

def aliquot_sum(num)
    proper_factors(num).inject { |acc,el| acc += el }
end

def perfect_number?(num)
    num == aliquot_sum(num)
end

def ideal_numbers(n)
    perfect_numbers = []
    count = 1
    while perfect_numbers.length < n
        perfect_numbers << count if perfect_number?(count)
        count += 1
    end
    perfect_numbers
end
