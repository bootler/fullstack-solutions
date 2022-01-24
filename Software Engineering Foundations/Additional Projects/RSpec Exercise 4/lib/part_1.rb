# RSpec Exercise 4 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/rspec-exercise-4
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require('byebug')

def my_reject(arr, &prc)
    arr.select { |el| !prc.call(el) }
end

def my_one?(arr, &prc)
    arr.select { |el| prc.call(el) }
        .length == 1
end

def hash_select(hsh, &prc)
    hsh.reject { |k,v| !prc.call(k,v) }
end

def xor_select(arr, prc_a, prc_b)
    arr.select { |el| prc_a.call(el) ^ prc_b.call(el) }
end

def proc_count(val, arr)
    arr.select { |el| el.call(val) }.length
end
