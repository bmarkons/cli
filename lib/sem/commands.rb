module Sem
  class Commands

    # load all commands
    require_relative "commands/base"
    Dir["#{File.dirname(__FILE__)}/commands/**/*.rb"].sort.each { |f| require(f) }

    def self.all
      ObjectSpace.each_object(Class).select { |klass| klass < Sem::Commands::Base }
    end

    def self.top_level
      all.select { |command| command.cli_name !~ /.*\:.*/ }
    end

    def self.run(command, params)
      handler = all.find { |handler| handler.cli_name == command }

      if handler
        handler.run(params)
      else
        puts "Show help"
      end
    end

  end
end
