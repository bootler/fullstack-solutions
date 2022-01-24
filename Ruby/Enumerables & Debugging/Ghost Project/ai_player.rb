# Ghost Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/ghost
# ai_player.rb by: Alex Boutilier
require_relative('./game.rb')

class AiPlayer
    attr_reader :name

    # haven't received this message yet :)
    def alert_invalid_guess
        puts "Ai player tried to make an invalid guess! This needs debugging :) "
    end

    def all_words_lose?(fragment)
        len = fragment.length
        n = @num_other_players
        dict = @game.dictionary.select { |word| word[0...len] == fragment }
        dict.all? { |word| (word.length - len) % n == 0 }
    end

    def all_words_win?(fragment)
        len = fragment.length
        n = @num_other_players
        dict = @game.dictionary.select { |word| word[0...len] == fragment }
        dict.none? { |word| (word.length - len) % n == 0 }
    end

    def initialize(name, game)
        @name = name
        @game = game
        @num_other_players = 0
    end

    def guess
        @num_other_players = @game.players.length - 1
        candidates = {}
        losers = [] # one will be picked at random if all possible guesses lose on the spot
        
        # check to see if a win or loss can be forced on the spot.
        ('a'..'z').each do |letter|
            fragment = @game.fragment + letter
            if !@game.valid_play?(letter)
                next
            elsif @game.dictionary.member?(fragment)
                losers << letter
            elsif @game.dictionary.all? { |word| word.length - fragment.length <= @num_other_players }
                return letter
            else
                candidates[letter] = 0
            end
        end
        return losers[rand(0...losers.length)] if candidates.length == 0
        candidates.each do |k,v|
            candidates[k] = simulate(@game.fragment + k)
        end
        puts candidates.max[0]
        candidates.max[0] 
    end

    def simulate(fragment)
        return 0 if !self.words_left?(fragment)
        score = 0
        ('a'..'z').each do |letter|
            new_frag = fragment + letter
            if !self.words_left?(new_frag)
                next
            elsif self.all_words_win?(new_frag)
                score += 1
                return score
            elsif self.all_words_lose?(new_frag)
                score -= 1
                return score
            else
                score += self.simulate(new_frag)
            end
        end
        score
    end

    def words_left?(fragment)
        len = fragment.length
        @game.dictionary.select { |word| word[0...len] == fragment }.length > 0
    end
end

