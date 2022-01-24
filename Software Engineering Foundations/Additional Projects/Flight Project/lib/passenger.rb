# Flight Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/flight-project
# passenger.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Passenger
    def initialize(name)
        @name = name
        @flight_numbers = []
    end

    def name
        @name
    end

    def has_flight?(flight_number)
        @flight_numbers.any? { |num| num == flight_number.upcase }
    end

    def add_flight(flight_number)
        @flight_numbers << flight_number.upcase if !self.has_flight?(flight_number)
        true
    end
end
    