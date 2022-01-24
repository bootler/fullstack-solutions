# Monkey Patching Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/monkey-patching-project
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  
    def span
        return nil if self.length == 0
        return self.max - self.min
    end

    def average
        return nil if self.length == 0
        return (self.sum * 1.0 ) / (self.length * 1.0)
    end

    def median
        ary = self.sort
        return nil if ary.length == 0
        return ary[(ary.length / 2).truncate] if ary.length % 2 != 0
        return [ary[(ary.length / 2) - 1], ary[ary.length / 2]].average
    end

    def counts
        hash = Hash.new(0)
        self.each do |el|
            hash[el] += 1
        end
        return hash
    end

    def my_count(val)
        counts[val]
    end

    def my_index(val)
        self.each_with_index do |el,idx|
            return idx if val == el
        end
        return nil
    end

    def my_uniq
        arr = []
        cmp = []
        self.inject(0) do |acc,el|
            cmp << acc
            arr << el if !cmp.include?(el)
            el
        end
        return arr
    end

    def my_transpose
        (0...self.length).each do |i|
            j = i + 1
            while j < self.length do
                self[i][j], self[j][i] = self[j][i],self[i][j]
                j += 1
            end
        end
        return self
    end
end
