# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# human_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class HumanPlayer
    def initialize(size, match_req)
    end
    
    def prompt
        puts "Pick a row and column (e.g. 1 3) to guess your card."
        STDIN.gets.chomp.split.map(&:to_i)
    end

    def receive_revealed_card(pos, value)
    end

    def receive_match(positions)
    end
end