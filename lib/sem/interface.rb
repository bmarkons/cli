module Sem
  class Interface < Thor
    require_relative "interface/teams"

    register(Sem::Interface::Teams, "teams", "teams <command>", "Manage teams on Semaphore")
  end
end
