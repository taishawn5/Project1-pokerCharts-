
require_relative "./code"
require 'optparse'

@options = {}
OptionParser.new do |opts|
  opts.on("-pPOS", "--position=POS", "doc this") do |val|
    @options[:position] = Integer(val)
  end
end.parse!

action = calculate_action(
  Position.new(9, @options[:position], 9),
  Hand.new(Card.new(2,'Spades'), Card.new(3, 'Spades')),
  Stack.new(current_blind = 2, chip_stack = 10)
)

puts action
#
# TODO: Add optparse to parse the CLI input
# https://www.rubyguides.com/2018/12/ruby-argv/
# pass is to calculate_action to get the result
# puts the result
