# frozen_string_literal: true

require_relative "operator"
require_relative "tokenizer"
require_relative "traceable"

module RpnUIA
  # a class to convert infix to postfix one step at a time
  class Converter
    extend Traceable
    define_trace :state

    attr_reader :input, :output, :ops

    def initialize
      @input = []
      @ops = []
      @output = []
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

      save_state
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
      if any_previous_state?
        restore_previous_state
        true
      else
        false
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
      clear_state
    end
  end

  con = Converter.new
  # pp Converter.singleton_class.ancestors
  pp Converter.singleton_methods
  pp Converter.instance_variable_get("@to_be_traced")
  pp con.instance_variables
  pp Converter.class_variables
end
