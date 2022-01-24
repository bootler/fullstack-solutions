require_relative "room"
require "byebug"

class Hotel
  
    def initialize(name,hash)
        @name = name
        @rooms = {} 
        hash.each do |k,v|
            @rooms[k] = Room.new(v)
        end
    end

    def name
        words = @name.split(" ")
        words.each_index do |idx|
            words[idx][0] = words[idx][0].upcase
        end
        words.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room_name)
        return true if @rooms.key?(room_name)
        return false
    end

    def check_in(person,room_name)
        if !room_exists?(room_name)
            p "sorry, room does not exist"
        else
            if @rooms[room_name].add_occupant(person)
                p "check in successful"
            else
                p "sorry, room is full"
            end
        end
    end
    
    def has_vacancy?
        return false if @rooms.values.all? { |room| room.full? }
        return true
    end

    def list_rooms
        @rooms.each { |k,v| puts k + v.available_space.to_s }
    end
end
