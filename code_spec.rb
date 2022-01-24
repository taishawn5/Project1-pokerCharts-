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
      expect(Position.new(9, 5, 9).pos1?).to eq(true)
    end
  end
  describe "pos3" do
    it "is true for HJ and CO" do
      expect(Position.new(9, 7, 9).pos1?).to eq(true)
    end
  end
  describe "pos4" do
    it "is true for dealer buton" do
      expect(Position.new(9, 9, 9).pos1?).to eq(true)
    end
  end
  describe "pos5" do
    it "is true for small blind" do
      expect(Position.new(9, 1, 9).pos1?).to eq(true)
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
  # how to handle each if case when writing tests
  describe "high_value" do
    it "returns the highest card value" do
      expect(Hand.new(Card.new(5,'Spades'), Card.new(2,'Spades')).high_value).to eq(3) #suited
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(5,'Spades')).high_value).to eq(8)  #pair

      expect(Hand.new(Card.new(5,'Spades'), Card.new(6,'Hearts')).high_value).to eq(2) #connectors
      expect(Hand.new(Card.new(5,'Spades'), Card.new(4,'Hearts')).high_value).to eq(2) #connectors

      expect(Hand.new(Card.new(5,'Clubs'), Card.new(7,'Spades')).high_value).to eq(1)  #gap Connectors
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(3,'Spades')).high_value).to eq(1)  #gap Connectors

    end
  end
  describe "value_if_paired" do
    it "is true if card values equal expected value" do
      expect(Hand.new(Card.new(5,'Clubs'), Card.new(5,'Spades')).value_if_paired).to eq(10)
    end
  end
end

# needs help with what variables to pass in.
RSpec.describe Stack do
  describe "small" do
    it "is true if BB is less than  20" do
      expect(Stack.new(current_blind = 2, chip_stack = 30).small?).to eq(true)
    end
  end
  describe "average" do
    it "is true if BB is more than 20 and less than 40" do
      expect(Stack.new(current_blind = 2, chip_stack = 50).average?).to eq(true)
    end
  end
  describe "large" do
    it "is true if BB is more than 40" do
      expect(Stack.new(current_blind = 2, chip_stack = 100).large?).to eq(true)
    end
  end
end

RSpec.describe "calculate_action" do
  it "is RAISE when a pos1 has a high-value pair hand" do

  end
end