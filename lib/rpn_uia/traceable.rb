module RpnUIA
  #
  # Add functionality to save and restore anything
  #
  module Traceable
    # define what is to be traced
    #
    # define_trace(method/variable)
    #
    # eg.
    # define_trace :state
    #
    def define_trace(*values)
      values.each do |value|
        attr_accessor value.to_sym

        define_traces value
        define_save   value
        define_clear  value
        define_restore value
        define_previous value
      end
    end

    private

    def define_traces(value)
      define_method("#{value}_traces") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          @#{value}_traces ||= []
        HERE
      end
    end

    def define_save(value)
      define_method("save_#{value}") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          #{value}_traces << #{value}
        HERE
      end
    end

    def define_clear(value)
      define_method("clear_#{value}") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          #{value}_traces.clear
        HERE
      end
    end

    def define_previous(value)
      define_method("any_previous_#{value}?") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          !#{value}_traces.empty?
        HERE
      end
    end

    def define_restore(value)
      define_method("restore_previous_#{value}") do
        instance_eval <<~HERE, __FILE__, __LINE__ + 1
          raise NoTraceFoundError if #{value}_traces.empty?
          self.#{value} = #{value}_traces.pop
        HERE
      end
    end
  end
end
