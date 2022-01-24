def hipsterfy(word)
    id = 0
    flag = false
    arr = word.split("")
    arr.each.with_index do |ele,idx|
        if "aeiou".include?(ele)
            id = idx
            flag = true
        end
    end
    if flag
        arr[id] = ""
        return arr.join("")
    else
        return word
    end
end

def vowel_counts(str)
    hash = Hash.new(0)
    str.each_char do |ch|
        hash[ch.downcase] += 1 if "aeiou".include?(ch.downcase)
    end
    return hash
end

def caesar_cipher(msg,num)
    alph_l = "abcdefghijklmnopqrstuvwxyz"
    alph_u = alph_l.upcase

    arr = msg.split("")

    arr.each_with_index do |ele,idx|
        if alph_l.include?(ele)
            letter = alph_l.split("").find_index(ele)
            if letter + num < 26
                arr[idx] = alph_l.split("")[letter + num]
            else
                arr[idx] = alph_l.split("")[(letter + num) % 26]
            end
        elsif alph_u.include?(ele)
            cap = alph_u.split("").find_index(ele)
            if cap + num < 26
                arr[idx] = alph_u.split("")[cap + num]
            else
                arr[idx] = alph_u.split("")[(cap + num) % 26]
            end
        else
        end
    end
    return arr.join("")
end




