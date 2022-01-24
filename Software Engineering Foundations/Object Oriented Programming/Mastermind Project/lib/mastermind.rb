require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(guess)
        puts @secret_code.num_exact_matches(guess)
        puts @secret_code.num_near_matches(guess)
    end

    def ask_user_for_guess
        print "Enter a code: "
        code = Code.from_string(gets.chomp)
        print_matches(code)
        return true if code == @secret_code
        return false
    end
end
