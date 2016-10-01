require 'add_on'

describe "Enumerable" do
  describe "my_each" do
    context "handles empty data" do
      it "returns nothing" do
        expect([].my_each).to eq([])
      end
    end

    context "has one element" do
      it "returns one element" do
        expect([1].my_each { |x| x }).to eq([1])
      end
    end

    context "has many elements" do
      it "returns many elements" do
        expect([1, 2, 3].my_each { |x| x }).to eql([1, 2, 3])
      end
    end
  end

  describe "my_count" do
    context "has no data" do
      it "is empty" do
        expect([].my_count?).to eql(0)
      end
    end

    context "has data" do
      it "gives correct count" do
        expect([1].my_count? {|x| x }).to eql(1)
        expect([1, 2].my_count? {|x| x }).to eql(2)
      end
    end
  end

  describe "my_none?" do
    context "has none" do
      it "returns none" do
        expect([1].my_none? { |x| x % 2 == 0 }).to be true
      end
    end

    context "has something" do
      it "returns false" do
        expect([2].my_none? { |x| x % 2 == 0 }).to be false
      end
    end
  end

  describe "my_all?" do
    context "has all" do
      it "returns true" do
        expect([2].my_all? { |x| x % 2 == 0 }).to be true
      end
    end

    context "has none" do
      it "returns false" do
        expect([1].my_all? { |x| x % 2 == 0 }).to be false
      end
    end
  end

  describe "my_select" do
    context "has data" do
      it "returns evaluated expression in a new array" do
        expect([1, 2, 3].my_select { |x| x % 2 == 0}).to eq([2])
      end
    end
  end
end