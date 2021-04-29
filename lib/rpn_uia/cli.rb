# frozen_string_literal: true

require "tty-prompt"
require "pastel"

require_relative "converter"
require_relative "visualizer"
require_relative "table"

module RpnUIA
  # Command line interface helper
  #
  # iterator object has to repond to #next & #back
  #
  class CLI
    def initialize(iterator: Converter.new)
      @visualizer = Visualizer.new
      @iterator = iterator
    end

    def run
      prompt = TTY::Prompt.new

      catch :shutdown do
        loop do
          input = prompt.ask("Please input infix expression ( press Q to quit )",
                             required: true)
          break if input.downcase == "q"

          @iterator.input = input
          @visualizer.object = @iterator

          display

          loop do
            next_or_back = prompt.select("Next/Back or Quit",
                                         %w[next back quit])
            case next_or_back
            when "next"
              done = @visualizer.next
              break unless done
            when "back"
              @visualizer.back
            when "quit"
              throw :shutdown
            end
            display
          end

          puts
          display_result(input, @iterator.output.to_a.join(" "))
          puts
        end
      end
    end

    def display(height: nil)
      system("clear")
      puts @visualizer.visualize height: height
    end

    def display_result(input, result)
      table = Table.new headers: %w[Infix Postfix], columns: [[input], [result]]
      puts table.render
    end
  end
end
