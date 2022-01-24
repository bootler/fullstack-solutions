# RSpec Exercise 5 - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/rspec-exercise-5
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require('byebug')

def zip(*arrs)
    arg_len = arrs.length           # <= how many subarrays were in the argument
    arr_len = arrs[0].length        # <= length of each subarray (they are by spec all the same size)
    arrs.flatten!
    zipped = []

    (0...arr_len).each do |i|
        to_zip = []
        count = i
        arg_len.times do
            to_zip << arrs[count]
            count += arr_len
        end
        zipped << to_zip
    end
    zipped
end

def prizz_proc(arr,prc_a,prc_b)
    arr.select { |el| prc_a.call(el) ^ prc_b.call(el) }
end
        
def zany_zip(*arrs)
    arg_len = arrs.length           
    arr_len = arrs.max { |a,b| a.length <=> b.length }.length    # <= this time we need the length of the longest subarray
    zipped = []

    (0...arr_len).each do |i|
        to_zip = []
        arrs.each { |arr| to_zip << arr[i] }
        zipped << to_zip
    end
    zipped
end

def maximum(arr, &prc)
    return nil if arr == []
    arr.max { |a,b| (prc.call(a) + arr.rindex(a)) <=> (prc.call(b) + arr.rindex(b)) }
end

def my_group_by(arr, &prc)
    group = Hash.new { |h,k| h[k] = [] }
    arr.each { |el| group[prc.call(el)] << el }
    group
end

def max_tie_breaker(arr, prc, &prc_b)
    return nil if arr == []
    cutoff = prc_b.call(
        arr.max { |a,b| prc_b.call(a) <=> prc_b.call(b) }
    )
    finalists = arr.select { |el| prc_b.call(el) == cutoff }
    return finalists[0] if finalists.length == 1
    
    winner = finalists.max { |a,b| prc.call(a) <=> prc.call(b) }
end

def silly_syllables(sentence)
    words = sentence.split(' ')
    sylbs = []

    words.each do |word|
        if word.chars.select { |c| "aeiou".include?(c) }.length >= 2

            vowels = word.chars.select { |c| "aeiou".include?(c) }
            l = word.chars.index(vowels[0])
            r = word.chars.rindex(vowels[-1])

            sylbs << word[l..r]
        else
            sylbs << word
        end
    end
    sylbs.join(' ')
end
