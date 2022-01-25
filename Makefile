

test:
	rspec code_spec.rb

clitests:
	ruby cli.rb --position=2
	#ruby cli.rb --position=2 --dealer=4 --card1-value=4 --card1-suit=spades --card2-value=6 --card2-suit=spades --stack=35 --blind=2
	#ruby cli.rb --position=2 --dealer=4 --card1-value=4 --card1-suit=spades --card2-value=6 --card2-suit=diamonds --stack=35 --blind=2
