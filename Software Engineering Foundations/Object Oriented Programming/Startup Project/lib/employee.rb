# Startup Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/startup-project
# employee.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Employee
    attr_reader :name, :title

    def initialize(name,title)
        @name = name
        @title = title
        @earnings = 0
    end

    def pay(amt)
        @earnings += amt
    end
end
