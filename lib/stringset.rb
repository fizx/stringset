class StringSet
  class Error < ::RuntimeError; end
  
  TOKENIZER = /\W+/
  
  attr_reader :strings
  
  def stemming? 
    !!@stemming
  end
  
  def initialize(strings, options = {})
    @stemming = options[:stem]
    @strings = tokenize strings
  end
  
  def substrings_in(strings)
    tokenize(strings) & @strings
  end
  
private

  def tokenize(strings)
    case strings
    when Array: 
      strings
    when String: 
      stem(strings.split(TOKENIZER))
    else
      raise Error.new("Could not tokenize")
    end
  end

  def stem(tokens)
    return tokens unless stemming?
    require "stemmer"
    tokens.map{|t| t.stem }
  end
end