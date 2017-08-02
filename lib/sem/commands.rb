module Sem
  module Commands

    # load all commands
    Dir["#{File.dirname(__FILE__)}/commands/**/*.rb"].each { |f| require(f) }

  end
end
