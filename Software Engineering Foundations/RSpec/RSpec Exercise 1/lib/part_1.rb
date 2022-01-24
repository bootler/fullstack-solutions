# RSpec Exercise 1 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/rspec-exercise-1
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
def average(num1,num2)
    return (num1+num2) / 2.0
end

def average_array(arr)
    return (arr.sum + 0.0) / arr.length
end

def repeat(str,num)
    st = ""
    num.times { st += str}
    return st
end

def yell(str)
    return str.upcase+"!"
end

def alternating_case(sentence)
    flag = true
    arr=sentence.split(" ")
    arr.each_index do |idx|
        if flag
            arr[idx].upcase!
            flag = false
        else
            arr[idx].downcase!
            flag = true
        end
    end
    return arr.join(" ")
end
            