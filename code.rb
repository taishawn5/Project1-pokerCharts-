
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
    return true if poker_table_add(@amt_players, @button_index, 3) == @position || poker_table_add(@amt_players, @button_index, 4) == @position
    return false
  end
  def pos2?
    return true if @button_index == 4 && (@position == 1)
    return true if @button_index == 5 && (@position == 1) || (@position == 2)
    return true if @button_index == 6 && (@position == 2) || (@position == 3)
    return true if @button_index == 7 && (@position == 3) || (@position == 4)
    return true if poker_table_add(@amt_players, @button_index, 5) == @position || poker_table_add(@amt_players, @button_index, 6) == @position
    return false
  end
  def pos3?
    return true if @button_index == 2 && (@position == 1)
    return true if @button_index == 3 && (@position == 1) || (@position == 2)
    return true if @button_index == 4 && (@position == 2) || (@position == 3)
    return true if @button_index == 5 && (@position == 3) || (@position == 4)
    return true if poker_table_add(@amt_players, @button_index, 7) == @position || poker_table_add(@amt_players, @button_index, 8) == @position
    return false
  end
  def pos4?
    return true if @button_index == @position
  end
  def pos5?
    if @button_index == 9
      return true if @position == 1
    end
    return true if @button_index + 1 == @position
    return false
  end
end

# (14, 9) => 5
#
def poker_table_mod(x, y)
  return x.modulo(y)
end

def poker_table_add(players, x, y)
  return poker_table_mod(x + y, players)
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

  def strength
    value = @card1.value + @card2.value
    if suited? #suited cards
      value += 3
    end
    if @card1.value == @card2.value #pokcet pair
      value += 8
    elsif @card1.value - @card2.value == 1 || @card1.value - @card2.value == -1 #connectors
      value += 2
    elsif @card1.value - @card2.value == 2 || @card1.value - @card2.value == -2 #connectors
      value += 1
    end
    return value
  end

  def paired_strength
    return self.pair? ? (@card1.value * 2) : 0
  end

  def suited?
    if card1.suit == card2.suit
      return true
    end
    return false
  end

  def value_if_paired
    return nil unless self.pair?
    return @card1.value + @card2.value
  end
end



class Stack
  def initialize(current_blind, chip_stack)
    @bb_amt = chip_stack / Float(current_blind)
  end
  def small?
    return @bb_amt <= 20
  end
  def average?
    return @bb_amt > 20 && @bb_amt <= 40
  end
  def large?
    return @bb_amt > 40
  end
end

def calculate_helper(hand)
  if hand.suited?
    calculate_suited_action(position, hand, stack)
  else
    calculate_action(position, hand, stack)
  end
end

def calculate_suited_action(position, hand, stack)
  if position.pos1?
    if stack.small?
      return Actions::ALLIN if hand.strength > 26
    elsif stack.average?
      return Actions::RAISE if hand.strength > 25
    elsif stack.large?
      return Actions::RAISE if hand.strength > 23
    end
  elsif position.pos2?
    if stack.small?
      return Actions::ALLIN if hand.strength > 24
    elsif stack.average?
      return Actions::RAISE if hand.strength > 22
    elsif stack.large?
      return Actions::RAISE if hand.strength > 18
    end
  elsif position.pos3?
    if stack.small?
      return Actions::ALLIN if hand.strength > 20
    elsif stack.average?
      return Actions::RAISE if hand.strength > 16
    elsif stack.large?
      return Actions::RAISE if hand.strength > 14
    end
  elsif position.pos4?
    if stack.small?
      return Actions::ALLIN if hand.strength > 19
    elsif stack.average?
      return Actions::RAISE if hand.strength > 12
    elsif stack.large?
      return Actions::RAISE if hand.strength > 10
    end
  elsif position.pos5?
    if stack.small?
      return Actions::ALLIN if hand.strength > 14
    elsif stack.average?
      return Actions::RAISE if hand.strength > 12
    elsif stack.large?
      return Actions::RAISE if hand.strength > 10
    end
  else
    raise RuntimeError, "unknown pos"
  end
  return Actions::FOLD
end

def calculate_action(position, hand, stack)
  if position.pos1?
    if stack.small?
      return Actions::ALLIN if hand.strength > 24 || hand.paired_strength >= 10
    elsif stack.average?
      return Actions::RAISE if hand.strength > 23 || hand.paired_strength >= 10
    elsif stack.large?
      return Actions::RAISE if hand.strength > 23 || hand.paired_strength >= 6
    end
  elsif position.pos2?
    if stack.small?
      return Actions::ALLIN if hand.strength > 24 || hand.paired_strength >= 10
    elsif stack.average?
      return Actions::RAISE if hand.strength > 22 || hand.paired_strength >= 8
    elsif stack.large?
      return Actions::RAISE if hand.strength > 20 || hand.paired_strength >= 6
    end
  elsif position.pos3?
    if stack.small?
      return Actions::ALLIN if hand.strength > 20 || hand.paired_strength >= 10
    elsif stack.average?
      return Actions::RAISE if hand.strength > 17 || hand.paired_strength >= 4
    elsif stack.large?
      return Actions::RAISE if hand.strength > 17 || hand.paired_strength >= 4
    end
  elsif position.pos4?
    if stack.small?
      return Actions::ALLIN if hand.strength > 16 || hand.paired_strength >= 4
    elsif stack.average?
      return Actions::RAISE if hand.strength > 13 || hand.paired_strength >= 4
    elsif stack.large?
      return Actions::RAISE if hand.strength > 9 || hand.paired_strength >= 4
    end
  elsif position.pos5?
    if stack.small?
      return Actions::ALLIN if hand.strength > 17 || hand.paired_strength >= 4
    elsif stack.average?
      return Actions::RAISE if hand.strength > 13 || hand.paired_strength >= 4
    elsif stack.large?
      return Actions::RAISE if hand.strength > 9 || hand.paired_strength >= 4
    end
  else
    raise RuntimeError, "unknown pos"
  end
  return Actions::FOLD
end