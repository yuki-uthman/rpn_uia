module RpnUIA
  #
  # Add functionality to save and restore anything
  #
  module Traceable
    # define the name of the variables to be traced
    #
    # instance variables will be created
    #
    # can override the behaviour from the class
    # if looking to save output of a method
    #
    # eg.
    # define_traces :state, :feeling
    #
    def define_traces(*values)
      values.each do |value|
        attr_accessor value.to_sym

        define_trace  value
        define_save   value
        define_clear  value
        define_restore value
        define_previous value
      end

      define_method("traces") do
        instance_exec(values) do
          @traces = values
        end
      end

      define_method("save_all") do
        traces.each do |trace|
          instance_eval <<~HERE, __FILE__, __LINE__ + 1
            save_#{trace}
          HERE
        end
      end
    end

    private

    def define_trace(value)
      define_method("#{value}_trace") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          @#{value}_trace ||= []
        HERE
      end
    end

    def define_save(value)
      define_method("save_#{value}") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          #{value}_trace << #{value}
        HERE
      end
    end

    def define_clear(value)
      define_method("clear_#{value}") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          #{value}_trace.clear
        HERE
      end
    end

    def define_previous(value)
      define_method("any_previous_#{value}?") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          !#{value}_trace.empty?
        HERE
      end
    end

    def define_restore(value)
      define_method("restore_previous_#{value}") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          raise NoTraceFoundError if #{value}_trace.empty?
          self.#{value} = #{value}_trace.pop
        HERE
      end
    end
  end
end
