# RSpec Exercise 2 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/rspec-exercise-2
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
def partition(arr,num)
    return [arr.select { |ele| ele < num },arr.select { |ele| ele >= num }]
end

def merge(h1,h2)
    return {**h1,**h2}
end

def censor(sent,curses)
    words = sent.split(" ")
    words.each do |word|
        if curses.any? { |curse| curse == word.downcase }
            word.each_char.with_index do |ch,idx|
                if "aeiou".include?(ch.downcase)
                    word[idx] = '*'
                end
            end
        end
    end
    return words.join(" ")
end

def power_of_two?(num)
    if Math.log2(num) % 1 == 0
        return true
    else
        return false
    end
end