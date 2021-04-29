# frozen_string_literal: true

require_relative "rpn_uia/version"
require_relative "rpn_uia/table"
require_relative "rpn_uia/tokenizer"
require_relative "rpn_uia/converter"
require_relative "rpn_uia/operator"
require_relative "rpn_uia/traceable"
require_relative "rpn_uia/visualizer"
require_relative "rpn_uia/cli"

module RpnUIA
  class Error < StandardError; end

  class NoTraceFoundError < StandardError; end
  # Your code goes here...
end
