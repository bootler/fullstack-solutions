# Word Chains - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/word-chains
# word_chainer.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'set'

class WordChainer
    attr_reader :all_seen_words
    def initialize(dictionary_filename)
        @dictionary = Set.new
        File.foreach(dictionary_filename) { |word| @dictionary << word.chomp }
        @current_words = []
        @all_seen_words = {}
    end

    def adjacent_words(word)
        possible_words = @dictionary.select { |w| w.length == word.length }
        possible_words.select do |wrd|
            count = 0
            (0...word.length).each do |i|
                count += 1 if wrd[i] == word[i]
            end
            count == word.length - 1
        end
    end

    def run(source, target)
        unless source.length == target.length
            puts "the two words must be the same length."
            return
        end
        @current_words = [source]
        @all_seen_words = {source => nil}
        until @current_words.empty? || @all_seen_words.keys.include?(target)
            new_current_words = []
            @current_words.each do |cur|
                new_current_words += explore_current_words(cur)
                break if new_current_words.include?(target)
            end
            @current_words = new_current_words
        end
        build_path(target)
    end

    def explore_current_words(word)
        new_current_words = []
        adjacent_words(word).each do |adj|
            next if @all_seen_words.include?(adj)
            new_current_words << adj
            @all_seen_words[adj] = word
        end
        new_current_words.each { |word| puts "\"#{word}\" <= \"#{@all_seen_words[word]}\"" }
        new_current_words
    end

    def build_path(target)
        path = [target]
        node = @all_seen_words[target]
        while node
            path << node
            node = @all_seen_words[node]
        end
        puts
        puts "Path: "
        puts "------"
        puts path.reverse.join(" => ")
    end
end

if __FILE__ == $PROGRAM_NAME
    WordChainer.new('./static/dictionary.txt').run('confer','jailor')
end
