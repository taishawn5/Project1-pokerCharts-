
class Actions
  RAISE = 'raise'
  FOLD = 'fold'
  CALL = 'call'
  ALLIN = 'allin'
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
    @value = 0
  end

  def pair?
    return true if card1.value == card2.value
  end

  def high_value
    #figure out what high value should be returning.
    #strength of hand on a scale (1-100)?
    #Scale will be 1-13 add points for big suited connectors, small connectors, etc
    @value = @card1 + @card2
    if @card1.suit == @card2.suit #suited cards
      @value += 3
    end
    if @card1.value == @card2.value #pokcet pair
      @value +=8
    end
    if @card1.value - @card2.value == 1 || @card1.value - @card2.value == -1 #connectors
      @value += 2
    end
    if @card1.value - @card2.value == 2 || @card1.value - @card2.value == -2 #connectors
      @value += 1
    end
  end

  def suited?
    if card1.suit == card2.suit
      return true
    end
    return false
  end

  def value_if_suited
    return @card1.value + @card2.value
  end
end



class Stack
  def initialize(current_blind, chip_stack)
    @bb_amt = chip_stack / current_blind
  end

  def small?
    return true if @bb_amt <= 20
  end

  def average?
    return true if @bb_amt > 20 && @bb_amt <= 40
  end
  def large?
    return true if @bb_amt > 40
  end
end


def calculate_action(position, hand, stack)
  # Should separate each calculation by suited hands, pairs and off suits so there
  # isn't hands fitting multiple calculations.
  if pos1?
    if small?
      if hand.high_value > 24 || (hand.pair? && hand.value_if_suited >= 10)
        return Actions::ALLIN
      end
      return Actions::FOLD
    end
    if average?
      if hand.high_value > 23 || (hand.pair? && hand.value_if_suited >= 10)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
    if large?
      if hand.high_value > 23 || (hand.pair? && hand.value_if_suited >= 6)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
  end

  if pos2?
    if small?
      if hand.high_value > 24 || (hand.pair? && hand.value_if_suited >= 10)
        return Actions::ALLIN
      end
      return Actions::FOLD
    end
    if average?
      if hand.high_value > 22 || (hand.pair? && hand.value_if_suited >= 8)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
    if large?
      if hand.high_value > 16 || (hand.pair? && hand.value_if_suited >= 6)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
  end

  if pos3?
    if small?
      if hand.high_value > 20 || (hand.pair? && hand.value_if_suited >= 10)
        return Actions::ALLIN
      end
      return Actions::FOLD
    end
    if average?
      if hand.high_value > 14 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
    if large?
      if hand.high_value > 12 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
  end

  if pos4?
    if small?
      if hand.high_value > 16 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions::ALLIN
      end
      return Actions::FOLD
    end
    if average?
      if hand.high_value > 10 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
    if large?
      if hand.high_value > 8 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
  end

  if pos5?
    if small?
      if hand.high_value > 12 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions::ALLIN
      end
      return Actions::FOLD
    end
    if average?
      if hand.high_value > 10 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
    if large?
      if hand.high_value > 8 || (hand.pair? && hand.value_if_suited >= 4)
        return Actions:: RAISE
      end
      return Actions::FOLD
    end
  end

end