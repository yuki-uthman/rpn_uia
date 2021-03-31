module RpnUIA
  # Add functionality to save and restore states
  # Must implement trace
  module Traceable
    def stack
      @stack ||= []
    end

    def clear_trace
      stack.clear
    end

    def save_trace
      stack.push trace
    end

    def pop_trace
      stack.pop
    end

    def any_trace?
      stack.empty?
    end
  end
end
