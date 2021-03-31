module RpnUIA
  #
  # Add functionality to save and restore states
  #
  module Traceable
    def self.included(base)
      base.extend Accessor
    end

    # define what is to be traced
    #
    # define_trace(method/variable)
    #
    # eg.
    # define_trace :state
    #
    module Accessor
      def define_trace(value)
        @trace = value

        alias_method "clear_#{value}",         :clear
        alias_method "save_#{value}",          :save
        alias_method "pop_#{value}",           :pop
        alias_method "restore_#{value}",       :restore
        alias_method "any_previous_#{value}?", :any_trace?
      end

      def trace
        @trace
      end
    end

    def traces
      @traces ||= []
    end

    def clear
      traces.clear
    end

    def save
      traces.push __send__(self.class.trace)
    end

    def pop
      traces.pop
    end

    def restore
      __send__("#{self.class.trace}=", pop)
    end

    def any_trace?
      traces.empty?
    end

    def show
      traces.dup
    end
  end
end
