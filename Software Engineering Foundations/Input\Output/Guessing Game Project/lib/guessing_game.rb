# Guessing Game Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/guessing-game-project
# guessing_game.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class GuessingGame

    def initialize(min,max)
        @secret_num = rand(min..max)
        @num_attempts = 0
        @game_over = false
    end

    def num_attempts
        @num_attempts
    end

    def game_over?
        @game_over
    end

    def check_num(num)
        @num_attempts += 1
        if num == @secret_num
            @game_over = true 
            p "you win"
        elsif num > @secret_num
            p "too big"
        else
            p "too small"
        end
    end

    def ask_user
        print "Enter a number: "
        input = gets.chomp.to_i
        check_num(input)
    end
end
