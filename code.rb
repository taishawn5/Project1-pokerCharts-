class Info
  # Gathers user data and information

  def initialize
    @position = ''
    @players = 0
    @amt_blinds = 0
  end

  def userData
    puts 'How many blinds do you have? '
    @amt_blinds = gets.chomp
    puts 'How many players are at your table?'
    @players = gets.chomp
    puts 'What position are you in (please enter in corresponding number)?
    1.SB 2.BB 3.UTG 4.UTG+1 5.UTG+2 6.LJ 7.HJ 8.CO 9.D'
    position = gets.chomp
  end
end

# Creates and calculates value of hands and what the user should do with that hand.
class Calculator

  def initialize
    super
  end
  def build
    # This function will build my Poker chart 2D array of all possible hands.
    # Will build three different ones for short stack, avg stack and a big stack.
  end
end