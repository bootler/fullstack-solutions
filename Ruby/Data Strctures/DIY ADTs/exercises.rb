# DIY ADTs - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/diy-adts
# Solutions by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions


# Problem 1:
# Write a Stack implementation using the following framework:
class Stack
    def initialize
      @ivar = []
    end

    def push(el)
      @ivar.push(el)
    end

    def pop
        @ivar.pop
    end

    def peek
        @ivar[-1]
    end
end

# Test cases:
s = Stack.new
(0...5).each { |i| s.push(i) }
p s.peek
5.times { p s.pop }
puts

# Exercise 2:
# Now let's write a Queue class. We will need the following instance methods: 
# enqueue(el), dequeue, and peek.
class Queue
    def initialize
      @ivar = []
    end

    def enqueue(el)
      @ivar.push(el)
    end

    def dequeue
        @ivar.shift
    end

    def peek
        @ivar[0]
    end
end

# Test cases:
q = Queue.new
(0...5).each { |i| q.enqueue(i) }
p q.peek
5.times { p q.dequeue }
puts

# Exercise 3:
# Let's write a Map class (following a similar pattern to Stack and Queue) 
# that implements a map using only arrays.
class Map
    def initialize
      @ivar = []
    end

    def set(key, value)
        found = @ivar.select { |pair| pair[0] == key }[0]
        if found
            found[1] = value
        else
            @ivar << [key, value]
        end
        true
    end

    def get(key)
        @ivar.select { |pair| pair[0] == key }[0]
    end

    def delete(key)
        @ivar.reject! { |pair| pair[0] == key }
    end

    def show
        @ivar.each { |pair| puts "{#{pair[0]} => #{pair[1]}}"}
    end
end

# Test cases:
m = Map.new
alph = ('a'..'e').to_a
(0...5).each do |i|
    m.set(alph[i], i + 1)
end
p m.get('e')
puts
m.delete('e')
p m.show
