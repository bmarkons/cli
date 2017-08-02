module Sem
  class Commands
    class Base

      def self.topic
        cli_name.split(":")[0]
      end

      def self.usage
        raise "Not implemented"
      end

      def self.description
        raise "Not implemented"
      end

      def self.cli_name
        name
          .gsub("Sem::Commands::", "")
          .split("::")
          .map(&:downcase)
          .join(":")
      end

      def self.usage
        raise "Not implemented"
      end

    end
  end
end
