# Error Handling Funtime - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/error-handling-funtime
# Note: This is a debugging exercise. To see how the original code was modified 
# please consult the commit history of this file in the following repository.
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# add new error type as part of phase 2
class CoffeeGivenError < StandardError
end

# PHASE [removed]
# Note: at time of writing, the exercise no longer specifies
# what to do about this method. We'll assume that the goal is to
# prevent any errors occuring in this method from halting the user script.
def convert_to_int(str)
  Integer(str)
rescue
  str
end

# PHASE 2
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeGivenError # raise the new error
  else
    raise StandardError 
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
rescue CoffeeGivenError # handle the new error
  retry
rescue # handle the other errors
  puts "This isn't a fruit!"
end  

# PHASE 3
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    # raise descriptive error enforcing yrs_known >= 5
    unless yrs_known.is_a?(Integer) && yrs_known >= 5
      raise "I can't be a best friend unless we've known each other for 5 years!"
    end
    # raise descriptive error if either name or pastime is an epty string
    unless name.length > 0 || fav_pastime.length > 0 
      raise "I need a name and favorite pastime!"
    end
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


