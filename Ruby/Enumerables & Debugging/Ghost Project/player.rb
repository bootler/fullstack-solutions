# Ghost Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/ghost
# player.rb by: Alex Boutilier

class Player
    attr_reader :name

    def alert_invalid_guess
        puts "No word can be formed from your guess! Make sure to enter a single letter and try again."
    end
    
    def initialize(name)
        @name = name
    end

    def guess
        gets.chomp.downcase
    end
end