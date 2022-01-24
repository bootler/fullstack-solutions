def palindrome?(word)
    flag = true
    arr = word.split("")
    rev = arr.reverse

    rev.each_with_index do |el,idx|
        if !(el == arr[idx])
            flag = false 
            break
        end
    end
    return flag
end

def substrings(str)
    subs = []
    (0...str.length).each do |i|
        (i...str.length).each do |j|
            subs << str[i..j]
        end
    end
    return subs
end

def palindrome_substrings(str)
    p_subs = []
    substrings(str).each do |ele|
        if palindrome?(ele) && ele.length > 1
            p_subs << ele
        end
    end
    return p_subs
end