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
        define_method(value) do
          instance_variable_get("@#{value}")
        end

        define_method("#{value}=") do |param|
          instance_variable_set("@#{value}", param)
        end

        define_method("#{value}_traces") do
          instance_eval <<~HERE, __FILE__, __LINE__ + 1
            @#{value}_traces ||= []
          HERE
        end

        define_method("save_#{value}") do
          instance_eval <<~HERE, __FILE__, __LINE__ + 1
            #{value}_traces << #{value}
          HERE
        end

        define_method("clear_#{value}") do
          instance_eval <<~HERE, __FILE__, __LINE__ + 1
            #{value}_traces.clear
          HERE
        end

        define_method("any_previous_#{value}?") do
          instance_eval <<~HERE, __FILE__, __LINE__ + 1
            !#{value}_traces.empty?
          HERE
        end

        define_method("restore_previous_#{value}") do
          instance_eval <<~HERE, __FILE__, __LINE__ + 1
            raise NoTraceFoundError if #{value}_traces.empty?
            self.#{value} = #{value}_traces.pop
          HERE
        end
      end
    end
  end
end
