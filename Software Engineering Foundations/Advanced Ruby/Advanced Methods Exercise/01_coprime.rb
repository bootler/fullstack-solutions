# Advanced Methods Exercise - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/advanced-methods-exercise
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Write a method, coprime?(num_1, num_2), that accepts two numbers as args.
# The method should return true if the only common divisor between the two numbers is 1.
# The method should return false otherwise. For example coprime?(25, 12) is true because
# 1 is the only number that divides both 25 and 12.

def coprime?(num1,num2)
    smol = [num1,num2].min
    large = [num1,num2].max
    facs = get_factors(smol)

    return facs.none? { |el| large % el == 0 }
end

def get_factors(num)
    arr = []
    (2..num).each do |ele|
        arr << ele if num % ele == 0
    end
    return arr
end


p coprime?(25, 12)    # => true
p coprime?(7, 11)     # => true
p coprime?(30, 9)     # => false
p coprime?(6, 24)     # => false
