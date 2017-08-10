require "spec_helper"

describe Sem::ThorExt::TopLevelThor do

  describe ".start" do
    it "splits the first argument and passes the values to the super class" do
      expect(Thor).to receive(:start).with([
        "teams",
        "projects",
        "list",
        "rt/devs"
      ])

      described_class.start(["teams:projects:list", "rt/devs"])
    end

    context "asking for help" do
      context "no arg provided" do
        it "passed the help to the super class" do
          expect(Thor).to receive(:start).with(["help"])

          described_class.start(["help"])
        end
      end

      context "argument passed" do
        it "splits the second argument" do
          expect(Thor).to receive(:start).with([
            "help",
            "teams",
            "projects",
            "list"
          ])

          described_class.start(["help", "teams:projects:list"])
        end
      end
    end
  end

end
