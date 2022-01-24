# Ghost Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/ghost
# game.rb by: Alex Boutilier
require_relative './player.rb'
require_relative './ai_player.rb'

class Game
    attr_reader :fragment, :players, :dictionary

    def eliminate_losers
        @players.each do |k,v|
            if v >= 5
                puts "Player #{k.name} has #{self.record(k)} and has been eliminated."
                puts "Press Enter to continue."
                gets
            end
        end
        @players.keep_if { |k,v| v < 5 }
        true
    end
    
    def initialize(player_details)
        @players = {}
        player_details.each do |k,v|
            if v
                @players[AiPlayer.new(k, self)] = 0
            else
                @players[Player.new(k)] = 0
            end
        end
        @current_player = @players.keys[0]
        @fragment = ""
        @dictionary = Set.new
        
        File.foreach('./static/dictionary.txt') { |word| @dictionary << word }
        @dictionary.map!(&:chomp)
    end

    def next_player
        i = (@players.keys.index(@current_player) + 1) % @players.length
        @current_player = @players.keys[i]
    end

    def play_round
        loop do
            p "Player #{@current_player.name}, please make a guess: "
            break if self.take_turn(@current_player)
            self.next_player
        end
        puts
        puts "----"
        puts "#{@current_player.name} formed word: #{@fragment} and loses the round!"
        @players[@current_player] += 1
        puts "#{@current_player.name} now has: #{self.record(@current_player)}"
        print "Press Enter to continue."
        gets
        true
    end

    def record(player)
        range = @players[player]
        return "<no letters>" if @players[player] == 0
        "GHOST"[0...range]
    end

    def reset_round
        @fragment = ""
        @current_player = @players.keys[0]
    end

    def run
        while @players.length > 1
            self.reset_round
            system("clear")
            @players.keys.each { |k| puts "Player #{k.name} has: #{self.record(k)}" }
            puts "----"
            puts
            self.play_round
            self.eliminate_losers
        end
        self.reset_round
        puts "Player #{@current_player.name}, you are the winner!"
    end

    def take_turn(player)
        loop do
            guess = player.guess
            if self.valid_play?(guess)
                @fragment += guess
                break
            else
                player.alert_invalid_guess
            end
        end
        @dictionary.member?(@fragment)
    end

    def valid_play?(str)
        f = @fragment + str
        str.length == 1 && @dictionary.any? { |word| word[0...f.length] == f }
    end
end