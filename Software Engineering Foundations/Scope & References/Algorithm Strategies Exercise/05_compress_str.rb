# Write a method, compress_str(str), that accepts a string as an arg.
# The method should return a new str where streaks of consecutive characters are compressed.
# For example "aaabbc" is compressed to "3a2bc".

def compress_str(str)
    st = ""
    prev_char = ''

    str.each_char.with_index do |ch,idx|
        
        if ch == prev_char
            next
        end

        count = get_count_repeating(str[idx..-1],ch)
        if count > 1
            st += count.to_s+ch
        else
            st += ch
        end
        prev_char = ch
    end
    return st
end

def get_count_repeating(substr,ch)
    count = 0
    flag = false
    substr.split("").inject(ch) do |acc,ele|
        if ele == acc && ele == ch && !flag
            count += 1
        else
            flag = true
        end
        ele
    end
    return count
end



p compress_str("aaabbc")        # => "3a2bc"
p compress_str("xxyyyyzz")      # => "2x4y2z"
p compress_str("qqqqq")         # => "5q"
p compress_str("mississippi")   # => "mi2si2si2pi"
