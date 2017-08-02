require "spec_helper"

describe Sem::Commands::Help do

  describe ".run" do
    it "displays the main help screen" do
      output = [
        "Usage: sem COMMAND",
        "",
        "Help topics, type \e[32msem help TOPIC\e[0m for more details:",
        "",
        "  teams  Manage teams and team membership",
        "  login  Log in to semaphore",
        "  help   Get help with the cli usage",
        "",
        ""
      ]

      expect { Sem::Commands::Help.run([]) }.to output(output.join("\n")).to_stdout
    end
  end
end
