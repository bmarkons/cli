require "sem/version"
puts Time.now.to_i
require "thor"
puts Time.now.to_i

module Sem
  require_relative "sem/interface"
  require_relative "sem/commands"
end
