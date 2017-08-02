require "io/console"
require "sem/version"
require "terminal-table"

module Sem
  module_function

  require_relative "sem/ui"
  require_relative "sem/commands"

  def run(params)
    command = params[0]
    params  = params[1..-1]

    Sem::Commands.run(command, params)
  end

end
