# class Info
  # Gathers user data and information

  # def initialize
  #   @position = ''
  #   @players = 0
  #   @amt_blinds = 0
  # end

  # def userData
  #   puts 'How many blinds do you have? '
  #   @amt_blinds = gets.chomp
  #   puts 'How many players are at your table?'
  #   @players = gets.chomp
  #   puts 'What position are you in (please enter in corresponding number)?
  #   1.SB 2.BB 3.UTG 4.UTG+1 5.UTG+2 6.LJ 7.HJ 8.CO 9.D'
  #   position = gets.chomp
  # end
# end

# Creates and calculates value of hands and what the user should do with that hand.
# class Calculator
#
#   def initialize
#     super
#   end
#   def build
#     # This function will build my Poker chart 2D array of all possible hands.
#     # Will build three different ones for short stack, avg stack and a big stack.
#   end
#   def calculate
#     # Takes user data figures out what chart to use and spits back out the appropriate action.
#   end
# end

class Actions
  RAISE = 'raise'
  FOLD = 'fold'
  CALL = 'call'
end

class Position
  def initialize(number_of_players, player_index, dealer_button_index)
  end

  def pos1?; end
  def pos2?; end
  def pos3?; end
  def pos4?; end
  def pos5?; end
end

class Card
  attr_accessor :value, :suit
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
end

class Hand
  attr_accessor :card1, :card2

  def initialize(card1, card2)
    @card1 = card1
    @card2 = card2
  end

  def pair?
  end

  def high_value
  end

  def suited?
  end
end


class Stack
  def initialize(current_blind, chip_stack); end
  def small?; end
  def average?; end
  def large?; end
end


def calculate_action(position, hand, stack)
  return Actions::RAISE if hand.pair? && hand.high_value > 5
  return Actions::FOLD
end