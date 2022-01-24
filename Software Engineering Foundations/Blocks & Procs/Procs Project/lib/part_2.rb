# Procs Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/procs-project
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
def reverser(str, &prc)
    return prc.call(str.reverse)
end

def word_changer(sent, &prc)
    words = sent.split(" ")
    words.each_index do |idx|
        words[idx] = prc.call(words[idx])
    end
    return words.join(" ")
end

def greater_proc_value(num, prc1, prc2)
    return [prc1.call(num),prc2.call(num)].max
end

def and_selector(arr, prc1, prc2)
    newArr = []
    arr.each do |el|
        newArr << el if prc1.call(el) && prc2.call(el)
    end
    return newArr
end

def alternating_mapper(arr, prc1, prc2)
    newArr = []
    (0...arr.length).each do |i|
        newArr << prc1.call(arr[i]) if i % 2 == 0
        newArr << prc2.call(arr[i]) if i % 2 != 0
    end
    return newArr
end
