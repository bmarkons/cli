module Sem
  module ThorExt

    #
    # Monkeypatching thor internals. TopLevelThor should be used for
    # as the entrypoint for the semaphore cli.
    #
    # Changed:
    #  - thor help screen
    #  - Thor.start to accept the form namespace:command
    #
    class TopLevelThor < Thor

      #
      # Thor doesn't really support the `sem teams:info` format.
      # So, before passing on the options to Thor, we split the
      # arguments.
      #
      #   The input 'teams:info' is converted to 'teams info' and
      #   sent to the super class.
      #
      # If the first argument is 'help', then we split the second
      # argument.
      #
      #   The input 'help teams:info' is converted to 'help teams info'
      #   and then sent to the super class.
      #
      def self.start(args = nil)
        super(process_args(args || ARGV))
      end

      #
      # Converts: ["teams:projects:info", "rt/devs"]
      #     into: ["teams", "projects", "info", "rt/devs"]
      #
      # Converts: ["help", "teams:projects:info", "rt/devs"]
      #     into: ["help", "teams", "projects", "info", "rt/devs"]
      #
      private_class_method def self.process_args(args)
        return [] if args.empty?

        if args[0] == "help"
          [args[0]] + process_args(args[1..-1])
        else
          args.shift.split(":") + args
        end
      end

      #
      # Overide orriginal implementation and hide namespace fom the commands banner.
      #
      def self.banner(command, _show_namespace = nil, subcommand = false)
        command.formatted_usage(self, false, subcommand)
      end

      def self.help(shell, subcommand = false)
        shell.say "Usage: sem COMMAND"
        shell.say
        shell.say "Help topics, type #{shell.set_color "sem help TOPIC", :cyan} for more details:"
        shell.say

        list = printable_commands(true, subcommand).reject { |cmd| cmd[0] =~ /help/ }

        shell.print_table(list, :indent => 2, :truncate => true)
        shell.say
      end

      def self.printable_commands(all = true, _subcommand = false)
        (all ? all_commands : commands).map do |_, command|
          next if command.hidden?
          next if command.name == "help"
          item = []
          item << banner(command, true, false)
          item << (command.description ? "    #{command.description.gsub(/\s+/m, " ")}" : "")
          item
        end.compact
      end

    end

  end
end
