# Flight Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/flight-project
# flight.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Flight
    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def passengers
        @passengers
    end

    def full?
        @passengers.length >= @capacity
    end

    def board_passenger(passenger)
        return false if self.full?
        if passenger.has_flight?(@flight_number)
            @passengers << passenger
            return true
        else
            return false
        end
    end

    def list_passengers
        @passengers.map { |p| p.name }
    end

    def [](idx)
        @passengers[idx]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end
