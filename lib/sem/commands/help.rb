module Sem
  module Commands
    module Help

      def self.run(_params)
        Sem::UI.info "Usage: sem COMMAND"
        Sem::UI.info ""

        Sem::UI.info "Help topics, type #{Sem::UI.strong "sem help TOPIC"} for more details:"
        Sem::UI.info ""

        topics = Sem::Commands::STRUCTURE.map do |topic, value|
          ["  #{topic}", value[:description]]
        end

        Sem::UI.table(topics)

        Sem::UI.info ""
      end

    end
  end
end
