require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "StringSet" do
  describe "#new" do
    it "should accept a string and tokenize it" do
      s = StringSet.new "tokenize me"
      s.strings.should == %w[tokenize me]
    end
    
    it "should accept an array of tokens" do 
      s = StringSet.new %w[tokenized list]
      s.strings.should == %w[tokenized list]
    end
    
    it "should have the option to stem" do
      s = StringSet.new %w[tokenized list], :stem => true
      s.should be_stemming
    end
  end
  
  describe "#substrings_in" do
    it "should return a list of common substrings" do
      s = StringSet.new "tokenize me"
      s.substrings_in("can you please tokenize me?").should == %w[tokenize me]
    end
    
    it "should account for stemming" do 
      s = StringSet.new "token me", :stem => true
      s.substrings_in("can you please tokenize me?").should == %w[token me]
    end
    
    it "should be pretty fast" do
      needles = %[love thine soldiers bananas monkeys bachelors masters doctorate]
      hamlet = File.read(File.join(File.dirname(__FILE__), "hamlet.txt"))
      Benchmark.measure do
        s = StringSet.new(needles)
        s.substrings_in(hamlet)
      end.real.should < 0.1
    end
  end
end
