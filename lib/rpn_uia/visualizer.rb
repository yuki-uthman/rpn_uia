# frozen_string_literal: true

require_relative "table"
require_relative "converter"

module RpnUIA
  # A class to visualize Converter or any other class
  #
  class Visualizer
    # to_visualize must implement 4 methods
    # #headers
    # #columns
    # #next
    # #back
    def initialize(to_visualize:)
      @object = to_visualize
      @table = Table.new
    end

    def next
      @object.next
    end

    def back
      @object.back
    end

    def visualize
      @table.headers = @object.headers
      @table.columns = @object.columns
      @table.render
    end
  end
end
