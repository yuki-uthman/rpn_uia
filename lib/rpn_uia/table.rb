# frozen_string_literal: true

require "tty-table"

module RpnUIA
  # A class to organize data with a header
  class Table
    attr_accessor :headers
    attr_reader   :height, :columns

    def initialize(headers: nil, columns: nil, height: 0)
      @headers = headers
      @columns = columns
      self.height = height
    end

    # Only modify the columns using this method for now
    #
    # @param [Array]
    #
    # @return [nil]
    #
    # @api public
    def columns=(arr)
      @columns = arr
      update_height
    end

    # Returns column either with a header name or an index
    # nil if cannot be found
    #
    # @param [Integer, String, Symbol] header
    #
    # @return [Array]
    #
    # @api public
    def column(index)
      index = case index
              when String
                @headers.index(index)
              when Symbol
                @headers.index(index.to_s)
              else
                index
              end

      columns[index] if index
    end

    # Returns the column with tallest height
    #
    # @return [Array]
    #
    # @api public
    def max_column
      @columns&.max_by(&:size)
    end

    # Only set the height if it is longer than the columns
    #
    # @param [Integer] value
    #
    # @return [nil]
    #
    # @api public
    def height=(value)
      @height = if @columns && value <= max_column.size
                  max_column.size
                else
                  value
                end
    end

    def empty?
      headers.nil? && columns.nil?
    end

    def to_a
      if empty?
        nil
      elsif headers.nil?
        [[nil], columns.dup]
      elsif columns.nil?
        [headers.dup, [nil]]
      else
        [headers.dup, columns.dup]
      end
    end

    def render(options = {})
      table = TTY::Table.new(header: headers)
      rows.each do |row|
        table << row
      end
      options = if options.empty?
                  default_options
                else
                  default_options.merge(options)
                end
      table.render(:unicode, options)
    end

    private

    def default_options
      { alignment: [:center], padding: [0, 1, 0, 1] }
    end

    # Should be called whenever the column change
    # expand the height or keep as it is depending on the new column
    #
    # @return [nil]
    def update_height
      @height = max_column.size if max_column.size > @height
    end

    def rows
      rows = []
      (@height - 1).downto(0) do |index|
        row = []
        columns.each do |column|
          row << column[index]
        end
        rows << row
      end
      rows
    end
  end # Table
end # RpnUIA
