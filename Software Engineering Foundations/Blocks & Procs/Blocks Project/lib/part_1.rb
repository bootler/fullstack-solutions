
def select_even_nums(nums)
    return nums.select { |num| num % 2 == 0}
end

def reject_puppies(dogs)
    return dogs.reject { |dog| dog["age"] <= 2 }
end

def count_positive_subarrays(grid)
    return grid.count { |arr| arr.sum > 0 }
end

def aba_translate(word)
    str = ""
    word.each_char do |ch|
        if "aeiou".include?(ch.downcase)
            str += ch+"b"+ch
        else
            str += ch
        end
    end
    return str
end

def aba_array(words)
    return words.map { |word| aba_translate(word) }
end