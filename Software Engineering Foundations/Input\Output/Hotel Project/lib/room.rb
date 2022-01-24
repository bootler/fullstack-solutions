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
