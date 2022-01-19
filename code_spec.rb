require 'rspec'

require_relative './code'

RSpec.describe Position do
  describe "pos1" do
    it "is true for UTG and UTG+1" do
      expect(Position.new(9, 3, 9).pos1?).to eq(3) || eq(4)
    end
  end
  describe "pos2" do
    it "is true for UTG and UTG+1" do
      expect(Position.new(9, 5, 9).pos1?).to eq(5) || eq(6)
    end
  end
  describe "pos3" do
    it "is true for UTG and UTG+1" do
      expect(Position.new(9, 7, 9).pos1?).to eq(7) || eq(8)
    end
  end
  describe "pos4" do
    it "is true for UTG and UTG+1" do
      expect(Position.new(9, 9, 9).pos1?).to eq(9)
    end
  end
  describe "pos5" do
    it "is true for UTG and UTG+1" do
      expect(Position.new(9, 1, 9).pos1?).to eq(1)
    end
  end
end

RSpec.describe Hand do
  describe "pair?" do
    it "is true if card values match" do
      expect(Hand.new(card1, card2).pair?).to eq(card1.value == card2.value)
    end
  end
  describe "suited?" do
    it "is true if suits match" do
      expect(Hand.new(card1, card2).suited?).to eq(card1.suit == card2.suit)
    end
  end
  describe "high_value" do
    it "returns the highest card value" do

    end
  end
end


RSpec.describe "calculate_action" do
  it "is RAISE when a pos1 has a high-value pair hand" do

  end


end