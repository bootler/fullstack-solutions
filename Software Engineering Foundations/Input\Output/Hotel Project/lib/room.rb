# Hotel Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/hotel-project
# room.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Room
    def initialize(cap)
        @capacity = cap
        @occupants = []
    end

    def capacity
        @capacity
    end

    def occupants
        @occupants
    end

    def full?
        if @occupants.length == capacity
            return true
        else
            return false
        end
    end

    def available_space
        @capacity - @occupants.length
    end

    def add_occupant(name)
        if !full?
            @occupants << name
            return true
        else
            return false
        end
    end 
end
