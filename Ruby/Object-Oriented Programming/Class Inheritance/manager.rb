# Class Inheritance - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/class-inheritance
# manager.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'employee'

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss=nil)
        super(name, salary, title, boss)
        @employees = []
    end

    def add_employees(subordinate)
        employees << subordinate
    end

    def bonus(multiplier)
        get_total_emp_salary * multiplier
    end

    protected

    def get_total_emp_salary
        salary = 0
        employees.each do |emp|
            if emp.is_a?(Manager)
                salary += (emp.salary + emp.get_total_emp_salary)
            else
                salary += emp.salary
            end
        end
        salary
    end
end

