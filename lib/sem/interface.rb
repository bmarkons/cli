module Sem
  class Interface < Thor
    register(Sem::Interface::Teams, "teams", "teams <command>", "Manage teams on Semaphore")
  end
end
