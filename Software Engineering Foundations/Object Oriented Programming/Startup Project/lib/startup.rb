require "employee"
require "byebug"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name,funding,salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return true if @salaries.key?(title)
        return false
    end

    def > (company)
        return true if self.funding > company.funding
        return false
    end

    def hire(name,title)
        if !valid_title?(title)
            raise "Sorry this title is invalid!"
        end
        @employees << Employee.new(name,title)
    end

    def size
        @employees.length
    end

    def pay_employee(emp)
        if @funding >= @salaries[emp.title]
            emp.pay(@salaries[emp.title])
            @funding -= @salaries[emp.title]
        else
            raise "Not enough funding!"
        end
    end

    def payday
        @employees.each { |emp| pay_employee(emp) }
    end

    def average_salary
        sals = []
        @employees.each do |emp|
            sals << @salaries[emp.title]
        end
        sals.sum / sals.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(competitor)
        @funding += competitor.funding
        competitor.salaries.each do |k,v|
            if !@salaries.key?(k)
                @salaries[k] = v
            end
        end
        @employees.push(*competitor.employees)
        competitor.close
    end

end
