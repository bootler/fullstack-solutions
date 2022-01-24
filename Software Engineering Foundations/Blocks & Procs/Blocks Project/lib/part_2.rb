# Blocks Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/blocks-project
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require "byebug"

def all_words_capitalized?(words)
    return words.all? { |word| word == word[0].upcase + word[1..-1].downcase}
end

def no_valid_url?(urls)
    return urls.none? { |url| url[-4..-1] == ".com" || url[-4..-1] == ".net" || url[-4..-1] == ".org" || url[-3..-1] == ".io"}
end

def any_passing_students?(students)
    return students.any? { |student| average(student[:grades]) >= 75 }
end

def average(grades)
    return grades.sum / grades.length
end