

test:
	rspec code_spec.rb

clitests:
	ruby cli.rb --position=2 --dealer=8 --card1v=14 --card1s=spades --card2v=2 --card2s=spades --stack=35 --blind=2
