# frozen_string_literal: true

require_relative "operator"
require_relative "tokenizer"

module RpnUIA
  # a class to convert infix to postfix one step at a time
  class Converter
    attr_reader :input, :output, :ops, :history

    def initialize
      @input = []
      @ops = []
      @output = []
      @history = []
    end

    def input=(expression)
      reset
      case expression
      when String
        @input = Tokenizer.tokenize(expression)
      when Array
        @input = expression
      end
    end

    def next
      return false if @input.empty? && @ops.empty?

      save
      if @input.empty?
        @output.push @ops.pop
      else
        case @input.last
        when Integer
          @output.push @input.pop
        when Symbol
          if Operator.compare(@input.last, @ops.last).positive?
            @ops.push @input.pop
          else
            @output.push @ops.pop
          end
        end
      end
      true
    end

    def back
      if @history.empty?
        false
      else
        self.state = @history.pop
        true
      end
    end

    def state=(arrays)
      @input = arrays[0]
      @ops = arrays[1]
      @output = arrays[2]
    end

    def state
      [@input.dup, @ops.dup, @output.dup]
    end

    private

    def reset
      @input = []
      @output = []
      @ops = []
      @history = []
    end

    def save
      @history.push state
    end
  end
end
