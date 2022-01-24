# Enumerable Exercises - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/enumerables
# Solutions by: Alex Boutilier

# Note: All solutions require extending the Array class
class Array

    # Problem 1: 
    # Extend the Array class to include a method named my_each that takes a block, 
    # calls the block on every element of the array, and returns the original array. 
    # Do not use Enumerable's each method.
    def my_each(&prc)
        for i in 0...self.length do
            prc.call(self[i])
        end
        self
    end

    # Problem 2:
    # Now extend the Array class to include my_select that takes a block and 
    # returns a new array containing only elements that satisfy the block. 
    # Use your my_each method!
    def my_select(&prc)
        arr = []
        self.my_each { |el| arr << el if prc.call(el) }
        arr
    end

    # Problem 3:
    # Write my_reject to take a block and return a new array 
    # excluding elements that satisfy the block.
    def my_reject(&prc)
        arr = []
        self.my_each { |el| arr << el if !prc.call(el) }
        arr
    end

    # Problem 4:
    # Write my_any? to return true if any elements of the array satisfy the block 
    # and my_all? to return true only if all elements satisfy the block.
    def my_any?(&prc)
        self.my_select { |el| prc.call(el) }.length > 0
    end

    def my_all?(&prc)
        self.my_select { |el| prc.call(el) }.length == self.length
    end

    # Problem 5:
    # my_flatten should return all elements of the array into a new, 
    # one-dimensional array. Hint: use recursion!
    def my_flatten
        arr = []
        self.my_each do |el|
            if el.is_a? Array
                arr += el.my_flatten
            else
                arr << el
            end
        end
        arr
    end

    # Problem 6:
    # Write my_zip to take any number of arguments. It should return a new array 
    # containing self.length elements. Each element of the new array should be an 
    # array with a length of the input arguments + 1 and contain the merged elements 
    # at that index. If the size of any argument is less than self, nil is returned 
    # for that location.
    def my_zip(*args)
        args.map! { |arg| arg.is_a? Array ? arg : [arg] }
        arr = []
        (0...self.length).each do |i|
            zipped = [self[i]]
            args.each { |arg| arg[i] ? zipped << arg[i] : zipped << nil }
            arr << zipped
        end
        arr
    end

    # Problem 7:
    # Write a method my_rotate that returns a new array containing all the elements 
    # of the original array in a rotated order. By default, the array should rotate 
    # by one element. If a negative value is given, the array is rotated 
    # in the opposite direction.
    def my_rotate(amount=1)
        if amount < 0
            amount.abs.times { self.unshift(self.pop) }
        else
            amount.times { self.push(self.shift) }
        end
        self
    end

    # Problem 8
    # my_join returns a single string containing all the elements of the array, 
    # separated by the given string separator. If no separator is given, an empty 
    # string is used.
    def my_join(separator="")
        str = ""
        self.my_each { |el| str += "#{el}#{separator}" }
        str[0...-1] # omit the last separator
    end
    
    # Problem 9
    # Write a method that returns a new array containing all the elements of the 
    # original array in reverse order.
    def my_reverse
        arr = []
        (1..self.length).each { |i| arr << self[-i] }
        arr
    end
end
