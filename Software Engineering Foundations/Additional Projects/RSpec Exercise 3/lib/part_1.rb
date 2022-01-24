# RSpec Exercise 3 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/rspec-exercise-3
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require('byebug')

def is_prime?(num)
    return false if num < 2
    (2...num).none? { |fact| num % fact == 0}
end

def nth_prime(n)
    primes = []
    count = 2
    while primes.length < n
        primes << count if primes.none? { |el| count % el == 0 }
        count += 1
    end
    primes[-1]
end


def prime_range(min,max)
    primes = []
    count = 2
    while count <= max
        primes << count if primes.none? { |el| count % el == 0 }
        count += 1
    end
    primes.select { |prime| prime >= min }
end

