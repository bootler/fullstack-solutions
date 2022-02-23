# Class Inheritance - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/class-inheritance
# employee.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Employee
    attr_accessor :boss
    attr_reader :name, :title, :salary

    def initialize(name, title, salary, boss=nil)
        @name = name
        @title = title
        @salary = salary
        self.boss = boss
    end

    def boss=(boss)
        @boss = boss
        boss.add_employees(self) if boss
        boss
    end

    def bonus(multiplier)
        @salary * multiplier
    end
end
