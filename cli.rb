
require_relative "./code"
require 'optparse'

@options = {}
OptionParser.new do |opts|
  opts.on("-pPOS", "--position=POS", "doc this") do |val|
    @options[:position] = Integer(val)
  end
  opts.on("-dDEAL", "--dealer=DEAL", "doc this") do |val|
    @options[:dealer] = Integer(val)
  end
  opts.on("-cCARD1V", "--card1v=CARD1V", "doc this") do |val|
    @options[:card1v] = Integer(val)
  end
  opts.on("-cCARD1S", "--card1s=CARD1S", "doc this") do |val|
    @options[:card1s] = String(val)
  end
  opts.on("-cCARD2V", "--card2v=CARD2V", "doc this") do |val|
    @options[:card2v] = Integer(val)
  end
  opts.on("-cCARD2S", "--card2s=CARD2S", "doc this") do |val|
    @options[:card2s] = String(val)
  end
  opts.on("-sSTACK", "--stack=STACK", "doc this") do |val|
    @options[:stack] = Integer(val)
  end
  opts.on("-bBLIND", "--blind=BLIND", "doc this") do |val|
    @options[:blind] = Integer(val)
  end
end.parse!

action = calculate_action(
  Position.new(9, @options[:position], @options[:dealer]),
  Hand.new(Card.new(@options[:card1v], @options[:card1s]), Card.new(@options[:card2v], @options[:card2s])),
  Stack.new(@options[:blind], @options[:stack])
)

puts action
#
# TODO: Add optparse to parse the CLI input
# https://www.rubyguides.com/2018/12/ruby-argv/
# pass is to calculate_action to get the result
# puts the result
