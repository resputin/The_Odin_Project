require "caesar_cipher"
  
describe ".caesar_cipher" do
  context "given out of bounds letters" do
    it "returns same letter" do
      expect(caesar_cipher(",", 5)).to eq(",")
    end
    it "handles spaces" do
      expect(caesar_cipher(" ", 5)).to eq(" ")
    end
  end

  context "given lowercase letters" do
    it "returns same letter" do 
      expect(caesar_cipher("a", 0)).to eq("a")
    end
    it "shifts correctly" do
      expect(caesar_cipher("a", 1)).to eq("b")
    end
    it "shifts over range" do
      expect(caesar_cipher("z", 1)).to eq("a")
    end
  end

  context "given uppercase letters" do
    it "returns same letter" do 
      expect(caesar_cipher("A", 0)).to eq("A")
    end
    it "shifts correctly" do
      expect(caesar_cipher("A", 1)).to eq("B")
    end
    it "shifts over range" do
      expect(caesar_cipher("Z", 1)).to eq("A")
    end
  end

  context "given phrases" do
    it "translates whole phrases" do
       expect(caesar_cipher("What a string!", 5)).to eq("Bmfy f xywnsl!") 
    end
  end
end