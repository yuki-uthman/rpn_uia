# frozen_string_literal: true

require_relative "operator"
require_relative "tokenizer"
require_relative "traceable"

module RpnUIA
  # a class to convert infix to postfix one step at a time
  class Calculator
    extend Traceable
    define_traces :state, :expresion_result

    attr_reader :input, :numbers, :expression, :expresion_result, :input_type

    def initialize(input: nil)
      @input_type = "postfix"
      if input.nil?
        @input = []
      else
        self.input = input
      end
      @numbers = []
      @expression = []
    end

    def headers
      %w[Input Numbers Expression]
    end

    def columns
      state
    end

    def input=(expression)
      reset
      case expression
      when String
        @input = Tokenizer.tokenize(expression).reverse
      when Array
        @input = expression.reverse
      end
    end

    def next
      return false if input.empty? && !@expresion_result

      save_state
      save_expresion_result

      if @expresion_result
        numbers.push @expresion_result
        @expresion_result = false
        return true
      end

      case input.last
      when Integer
        numbers.push input.pop
      when Symbol
        first = numbers.pop
        second = numbers.pop
        operator = input.pop

        expresion_result = calculate(second, operator, first)
        @expresion_result = expresion_result
        expression.push "#{second} #{operator} #{first} = #{expresion_result}"

      end
    end

    def back
      if any_previous_state?
        restore_previous_state
        restore_previous_expresion_result
        true
      else
        false
      end
    end

    def state=(arr)
      @input = arr[0]
      @numbers = arr[1]
      @expression = arr[2]
    end

    def state
      [@input.dup, @numbers.dup, @expression.dup]
    end

    def result
      @numbers.first
    end

    private

    def calculate(number1, operator, number2)
      case operator
      when :/
        Float(number1).__send__(operator, Float(number2))
      when :^
        number1**number2
      else
        number1.__send__(operator, number2)
      end
    end

    def reset
      @input = []
      @numbers = []
      @expression = []
      clear_state
    end
  end
end
