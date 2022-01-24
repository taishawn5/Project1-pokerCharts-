require 'rspec'

require_relative './code'

RSpec.describe Position do
  describe "pos1" do
    it "is true for UTG and UTG+1" do
      expect(Position.new(9, 3, 9).pos1?).to eq(true)
    end
  end
  describe "pos2" do
    it "is true for UTG+2 and LJ" do
      expect(Position.new(9, 5, 9).pos2?).to eq(true)
    end
  end
  describe "pos3" do
    it "is true for HJ and CO" do
      expect(Position.new(9, 7, 9).pos3?).to eq(true)
    end
  end
  describe "pos4" do
    it "is true for dealer buton" do
      expect(Position.new(9, 9, 9).pos4?).to eq(true)
    end
  end
  describe "pos5" do
    it "is true for small blind" do
      expect(Position.new(9, 1, 9).pos5?).to eq(true)
    end
  end
end

RSpec.describe Hand do
  describe "pair?" do
    it "is true if card values match" do
      expect(Hand.new(Card.new(5, 'Spades'), Card.new(5, 'Hearts')).pair?).to eq(true)
    end
  end
  describe "suited?" do
    it "is true if suits match" do
      expect(Hand.new(Card.new(5, 'Spades'), Card.new(10, 'Spades')).suited?).to eq(true)
    end
  end
  describe "strength" do
    it "returns the highest card value" do
      expect(Hand.new(Card.new(5,'Spades'), Card.new(2,'Spades')).strength).to eq(10) #suited
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(5,'Spades')).strength).to eq(18)  #pair

      expect(Hand.new(Card.new(5,'Spades'), Card.new(6,'Hearts')).strength).to eq(13) #connectors
      expect(Hand.new(Card.new(5,'Spades'), Card.new(4,'Hearts')).strength).to eq(11) #connectors

      expect(Hand.new(Card.new(5,'Clubs'), Card.new(7,'Spades')).strength).to eq(13)  #gap Connectors
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(3,'Spades')).strength).to eq(9)  #gap Connectors

    end
  end
  describe "value_if_paired" do
    it "is the paired value if paired" do
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(5,'Spades')).value_if_paired).to eq(10)
    end
    it "is nil if not paired" do
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(4,'Spades')).value_if_paired).to eq(nil)
    end
  end
end

# needs help with what variables to pass in.
RSpec.describe Stack do
  describe "small" do
    it "is true if BB is <= 20" do
      expect(Stack.new(current_blind = 2, chip_stack = 40).small?).to eq(true)
      expect(Stack.new(current_blind = 2, chip_stack = 41).small?).to eq(false)
    end
  end
  describe "average" do
    it "is true if BB is more than 20 and <= 40" do
      expect(Stack.new(current_blind = 2, chip_stack = 41).average?).to eq(true)
      expect(Stack.new(current_blind = 2, chip_stack = 40).average?).to eq(false)
      expect(Stack.new(current_blind = 2, chip_stack = 80).average?).to eq(true)
      expect(Stack.new(current_blind = 2, chip_stack = 81).average?).to eq(false)
    end
  end
  describe "large" do
    it "is true if BB is more than 40" do
      expect(Stack.new(current_blind = 2, chip_stack = 81).large?).to eq(true)
      expect(Stack.new(current_blind = 2, chip_stack = 80).large?).to eq(false)
    end
  end
end

RSpec.describe "calculate_action" do
  it "is ALLIN when a pos1 small stack has a high-value hand" do
    expect(calculate_action(Position.new(9, 3, 9),
                            Hand.new(Card.new(14,'Spades'), Card.new(13, 'Spades')),
                            Stack.new(current_blind = 2, chip_stack = 10))).to eq(Actions::ALLIN)

    expect(calculate_action(Position.new(9, 3, 9),
                            Hand.new(Card.new(14,'Spades'), Card.new(13, 'Spades')),
                            Stack.new(current_blind = 2, chip_stack = 46))).to eq(Actions::RAISE)

    expect(calculate_action(Position.new(9, 3, 9),
                            Hand.new(Card.new(14,'Spades'), Card.new(13, 'Spades')),
                            Stack.new(current_blind = 2, chip_stack = 100))).to eq(Actions::RAISE)
  end
  it "is FOLD when a hand strength doesn't meet the standards to raise or go all in" do
    expect(calculate_action(Position.new(9, 3, 9),
                            Hand.new(Card.new(2,'Spades'), Card.new(3, 'Spades')),
                            Stack.new(current_blind = 2, chip_stack = 10))).to eq(Actions::FOLD)
  end
end