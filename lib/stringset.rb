class StringSet
  class Error < ::RuntimeError; end
  
  TOKENIZER = /\W+/
  
  attr_reader :strings, :max_token_size
  
  def stemming? 
    !!@stemming
  end
  
  def initialize(strings = [], options = {})
    @stemming = options[:stem]
    @strings = tokenize strings
    @max_token_size = @strings.map{|str| str.split(TOKENIZER).length }.max 
    @strings.map! {|str| stem(str.split(TOKENIZER)).join(" ") } if stemming?
  end
  
  def substrings_in(strings)
    tokenize(strings, true) & @strings
  end

  def tokenize(strings, ngramize = false)
    tokens = case strings
    when Array: 
      strings
    when String: 
      stem(strings.split(TOKENIZER))
    else
      raise Error.new("Could not tokenize")
    end
    ngramize ? ngramize(tokens) : tokens
  end
  
  def ngramize(tokens, size = @max_token_size)
    buffer = []
    2.upto(size) do |n|
      0.upto(tokens.length - n) do |i|
        buffer << Array.new(n){|j| j }.map{|k| tokens[i+k] }.join(" ")
      end
    end
    tokens + buffer
  end

  def stem(tokens)
    return tokens unless stemming?
    require "stemmer"
    tokens.map{|t| t.stem }
  end
end