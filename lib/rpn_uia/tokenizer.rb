# frozen_string_literal: true

module RpnUIA
  # This class helps to tokenize the infix notation
  # to arrays of numbers and operators
  class Tokenizer
    def self.tokenize(string)
      tokens = string.split
      tokens.map do |token|
        Integer(token)
      rescue ArgumentError
        token.to_sym
      end
    end
  end
end
