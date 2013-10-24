require "spec_helper"

describe Xmlenc::Builder::DataReference do

  let(:xml) { File.read File.join("spec", "fixtures", "template.xml") }
  subject { described_class.parse(xml) }

  describe "#parse" do
    it "should have an uri object" do

    end
  end
end