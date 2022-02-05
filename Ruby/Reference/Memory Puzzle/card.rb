# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# card.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Card
    attr_reader :revealed, :face_value

    def initialize(value, is_revealed)
        @face_value = value
        @revealed = is_revealed
    end

    def value
        @revealed ? @face_value : " "
    end

    def hide
        @revealed = false
    end

    def show
        @revealed = true
    end

    def to_s
        return "#{self.value}"
    end

    def ==(card)
        @face_value == card.face_value
    end
end