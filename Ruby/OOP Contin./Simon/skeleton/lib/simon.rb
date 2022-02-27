# Simon - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/simon
# simon.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
      sleep(1)
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      system("clear")
      sleep(0.1) # help distinguish between repeating colors
      puts color
      sleep(1)
    end
  end

  def require_sequence
    colors = []
    system("clear")
    @sequence_length.times do
      puts "Please enter the next color in the sequence"
      colors << gets.chomp
    end
    @game_over = true unless colors == @seq
  end

  def add_random_color
    @seq << COLORS[rand(4)]
  end

  def round_success_message
    puts "Nicely done!"
  end

  def game_over_message
    puts "Sorry, you lose!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  Simon.new.play
end
