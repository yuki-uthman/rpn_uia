class Dummy
  extend RpnUIA::Traceable

  define_traces :state
end

class Cat
  extend RpnUIA::Traceable

  define_traces :state, :feeling
end
