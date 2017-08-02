class Sem::Commands::Help < Sem::Commands::Base

  def self.description
    "Show this help screen"
  end

  def self.run(params)
    if params.empty?
      show_main_help
    else
      topic = params.first
    end
  end

  def self.show_main_help
    Sem::UI.info "Usage: sem COMMAND"
    Sem::UI.info ""

    Sem::UI.info "Help topics, type #{Sem::UI.strong "sem help TOPIC"} for more details:"
    Sem::UI.info ""

    topics = Sem::Commands.top_level.map do |command|
      ["  #{command.topic}", command.description]
    end

    Sem::UI.table(topics)

    Sem::UI.info ""
  end

end
