require "io/console"
require "sem/version"
require "terminal-table"

module Sem
  module_function

  require_relative "sem/ui"
  require_relative "sem/commands"

  def run(params)
    command     = params.shift
    module_name = "::Sem::Commands::#{command.split(":").map(&:capitalize).join("::")}"
    handler     = const_get(module_name)

    if handler
      handler.run(params)
    else
      puts "show help"
    end
  end

end
