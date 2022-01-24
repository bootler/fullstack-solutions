class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length) { '_' }
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(ch)
    return true if @attempted_chars.any? { |el| el == ch }
    return false
  end

  def get_matching_indices(ch)
    arr = []
    @secret_word.each_char.with_index do |c,idx|
      arr << idx if c == ch
    end
    arr
  end

  def fill_indices(ch,indices)
    indices.each { |i| @guess_word[i] = ch }
  end

  def try_guess(ch)
    if already_attempted?(ch)
      p "that has already been attempted"
      return false
    end
    @remaining_incorrect_guesses -= 1 if get_matching_indices(ch).length == 0
    @attempted_chars << ch
    fill_indices(ch,get_matching_indices(ch))
    return true
  end

  def ask_user_for_guess
    p "Enter a char: "
    guess = gets.chomp
    return try_guess(guess)
  end

  def win?
    if @guess_word.join("") == @secret_word
      p "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if win? || lose?
      p @secret_word
      return true
    else
      return false
    end
  end
end
