# Bootcamp Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/bootcamp-project
# bootcamp.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Bootcamp
    def initialize(name,slogan,student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new { |k,v| k[v] = [] }
    end

    def name
        @name
    end

    def slogan
        @slogan
    end

    def teachers
        @teachers
    end

    def students
        @students
    end

    def hire(teacher)
        @teachers << teacher
    end

    def enroll(student)
        if @students.length < @student_capacity
        @students << student
        return true
        else
            return false
        end
    end

    def enrolled?(student)
        return students.any? { |ele| ele == student }
    end

    def student_to_teacher_ratio
        (@students.length / @teachers.length).truncate
    end

    def add_grade(student,grade)
        if enrolled?(student)
            @grades[student] = @grades[student] << grade
            return true
        else
            return false
        end
    end

    def num_grades(student)
        @grades[student].length
    end

    def average_grade(student)
        if enrolled?(student) && @grades[student].length > 0
            return @grades[student].sum / @grades[student].length
        else
            return nil
        end
    end
end
