module Sem
  class Invoke

    #
    # Finds a module that can handle the command,
    # and runs it. Example:
    #
    # Sem::Invoke.new("teams:info").run calls
    # Sem::Commands::Teams::Info.new(params).run
    #

    def initialize(command, params)
      @command = command
      @params = params
    end

    def handler_exists?
      handler != nil
    end

    def run
      @handler.new(@params).run
    end

    def handler
      @handler ||= const_get("::Sem::Commands::#{@command.split(":").map(&:capitalize).join("::")}")
    end

  end
end
