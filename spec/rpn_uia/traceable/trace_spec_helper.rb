class Dummy
  extend RpnUIA::Traceable

  define_trace :state
end

class Cat
  extend RpnUIA::Traceable

  define_trace :state
  define_trace :feeling
end
