
class Actions
  RAISE = 'raise'
  FOLD = 'fold'
  CALL = 'call'
end

class Position
  def initialize(number_of_players, player_index, dealer_button_index)
    @amt_players = number_of_players
    @position = player_index # corresponds to seat number 1 is first person to the left of the table dealer(not button)
    @button_index = dealer_button_index # corresponds to seat number 1 is first person to the left of the table dealer(not button)
  end
  # Position one will correspond to the under the gun player and so forth
  def pos1?
    return true if @button_index == 6 && (@position == 1)
    return true if @button_index == 7 && (@position == 1) || (@position == 2)
    return true if @button_index == 8 && (@position == 2) || (@position == 3)
    return true if @button_index == 9 && (@position == 3) || (@position == 4)
    return true if @button_index + 3 == @position || @button_index + 4 == @position
  end
  def pos2?
    return true if @button_index == 4 && (@position == 1)
    return true if @button_index == 5 && (@position == 1) || (@position == 2)
    return true if @button_index == 6 && (@position == 2) || (@position == 3)
    return true if @button_index == 7 && (@position == 3) || (@position == 4)
    return true if @button_index + 5 == @position || @button_index + 6 == @position
  end
  def pos3?
    return true if @button_index == 2 && (@position == 1)
    return true if @button_index == 3 && (@position == 1) || (@position == 2)
    return true if @button_index == 4 && (@position == 2) || (@position == 3)
    return true if @button_index == 5 && (@position == 3) || (@position == 4)
    return true if @button_index + 7 == @position || @button_index + 8 == @position
  end
  def pos4?
    return true if @button_index == @position
  end
  def pos5?
    if @button_index == 9
      return true if @position == 1
    end
    return true if @button_index + 1 == @position
  end
end

class Card
  attr_accessor :value, :suit
  def initialize(value, suit)
    #value will be 1-13 (Ace-King)
    @value = value
    @suit = suit #Spade,Club,Diamond,Heart
  end
end

class Hand
  attr_accessor :card1, :card2

  def initialize(card1, card2)
    @card1 = card1
    @card2 = card2
  end

  def pair?
    return true if card1.value == card2.value
  end

  def high_value
    #figure out what high value should be returning.
    #strength of hand on a scale (1-100)?
  end

  def suited?
    return true if card1.suit == card2.suit
  end
end


class Stack
  bb_amt = 0

  def initialize(current_blind, chip_stack)
    bb_amt = chip_stack / current_blind
  end

  def small?
    return true if bb_amt <= 20
  end

  def average?
    return true if bb_amt > 20 && bb_amt <= 40
  end
  def large?
    return true if bb_amt > 40
  end
end


def calculate_action(position, hand, stack)
  #after gathering all information can use functions to calculate what the user should do.
  return Actions::RAISE if hand.pair? && hand.high_value > 5
  return Actions::FOLD
end