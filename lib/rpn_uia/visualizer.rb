# frozen_string_literal: true

require_relative "table"
require_relative "converter"

module RpnUIA
  # A class to visualize Converter or any other class
  #
  class Visualizer
    attr_writer :object

    # to_visualize object must implement 4 methods
    # #headers
    # #columns
    # #next
    # #back
    def initialize(to_visualize: nil)
      @object = to_visualize
      @table = Table.new
    end

    def next
      @object.next
    end

    def back
      @object.back
    end

    def visualize(height: nil)
      @table.height = height unless height.nil?
      @table.headers = @object.headers
      @table.columns = @object.columns
      @table.render
    end
  end
end
