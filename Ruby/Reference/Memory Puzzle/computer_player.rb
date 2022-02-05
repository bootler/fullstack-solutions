# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# computer_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'game'

class ComputerPlayer
    def initialize
        @known_cards = {}
        @matched_cards = []
    end

    def prompt
    end

    def receive_revealed_card(pos, value)
        @known_cards[pos] = value
    end

    def receive_match
    end
end
