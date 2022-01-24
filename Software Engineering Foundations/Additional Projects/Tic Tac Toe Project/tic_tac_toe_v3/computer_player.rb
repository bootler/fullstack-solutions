class ComputerPlayer
    attr_reader :mark
    
    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        choice = legal_positions[rand(legal_positions.length)]
        puts "Computer player " + @mark.to_s + " placed mark at: " + choice.map(&:to_s).join(" ") + "."
        choice
    end
end