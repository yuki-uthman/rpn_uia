module RpnUIA
  # Add functionality to save and restore states
  # Must implement state
  module Traceable
    def trace
      @trace ||= []
    end

    def clear_trace
      trace.clear
    end

    def save_trace
      trace.push state
    end

    def restore_trace
      trace.pop
    end

    def any_trace?
      trace.empty?
    end
  end
end
