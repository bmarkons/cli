module Sem
  module Commands

    # load all commands
    Dir["#{File.dirname(__FILE__)}/commands/**/*.rb"].each { |f| require(f) }

    # TODO: this could be generated with magic

    STRUCTURE = {
      :teams => {
        :description => "Manage teams and team membership",
        :handler => Sem::Commands::Teams,

        :actions => {
          :info => {
            :description => "Show info about a team",
            :handler => Sem::Commands::Teams::Info,
          }
        }
      },

      :login => {
        :description => "Log in to semaphore",
        :handler => Sem::Commands::Login,
      },

      :help => {
        :description => "Get help with the cli usage",
        :handler => Sem::Commands::Help
      }
    }
  end
end
