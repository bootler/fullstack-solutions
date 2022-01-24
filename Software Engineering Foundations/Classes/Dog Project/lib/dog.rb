# Dog Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/dog-project
# dog.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Dog
    def initialize(name, breed, age, bark, favorite_foods)
        @name = name
        @breed = breed
        @age = age
        @bark = bark
        @favorite_foods = favorite_foods
    end

    def name
        @name
    end

    def breed
        @breed
    end

    def age
        @age
    end

    def age=(age)
        @age = age
    end

    def bark
        return @bark.upcase if @age > 3
        return @bark.downcase if @age <= 3
    end

    def favorite_foods
        @favorite_foods
    end

    def favorite_food?(food_item)
        favorite_foods.any? { |ele| ele.upcase == food_item.upcase }
    end  
end
