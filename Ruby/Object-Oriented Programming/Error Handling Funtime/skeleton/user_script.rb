require_relative 'super_useful'

puts "'five' == #{convert_to_int('five')}"

feed_me_a_fruit

# fix the errors raised by BestFriend#initialize.
sam = BestFriend.new('Sam', 5, 'singing')

sam.talk_about_friendship
sam.do_friendstuff
sam.give_friendship_bracelet
