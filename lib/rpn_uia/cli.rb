# frozen_string_literal: true

require "tty-prompt"
require "pastel"

require_relative "table"

module RpnUIA
  # Command line interface helper
  #
  # iterator object must respond to:
  #
  # for informing the user for appropriate expression
  # #input_type
  #
  # for move its state back and forth
  # #next
  # #back
  #
  # for table rendering
  # #columns
  # #headers
  #
  # for displaying the result
  # #output
  #
  class CLI
    def self.run(title:, iterator:)
      CLI.new(title: title, iterator: iterator).run
    end

    def initialize(title:, iterator:)
      @title = "# #{title} #"
      @table = Table.new
      @iterator = iterator
    end

    def run
      prompt = TTY::Prompt.new

      catch :shutdown do
        loop do
          clear
          display_title
          input = prompt
                  .ask("Please input #{@iterator.input_type} expression ( press Q to quit )",
                       required: true)
          break if input.downcase == "q"

          @iterator.input = input

          clear
          display_title
          display_table

          loop do
            next_or_back = prompt.select("Next/Back or Quit",
                                         %w[next back quit])
            case next_or_back
            when "next"
              done = @iterator.next
              break unless done
            when "back"
              @iterator.back
            when "quit"
              throw :shutdown
            end
            clear
            display_title
            display_table
          end

          puts
          display_result(input, @iterator.output.to_a.join(" "))
          puts

          continue_or_quit = prompt
                             .select("Continue or Quit", %w[continue quit])

          case continue_or_quit
          when "continue"
            next
          when "quit"
            throw :shutdown
          end
        end
      end
    end

    def clear
      system("clear")
    end

    def display_title
      puts @title
    end

    def display_table
      @table.headers = @iterator.headers
      @table.columns = @iterator.columns
      puts @table.render
    end

    def display_result(input, result)
      table = Table.new headers: %w[Input Result], columns: [[input], [result]]
      puts table.render
    end
  end
end
