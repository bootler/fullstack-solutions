# Battleship Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/battleship-project
# player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Player
    def get_move
        print "enter a position with coordinates separated with a space like '4 7'"
        gets.chomp.split(" ").map(&:to_i)
    end
end
