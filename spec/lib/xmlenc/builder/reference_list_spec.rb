require "spec_helper"

describe Xmlenc::Builder::ReferenceList do

  let(:xml) { File.read File.join("spec", "fixtures", "template.xml") }
  subject { described_class.parse(xml) }

  describe "#parse" do
    subject.each do |item|
      it "has data" do
        puts item.inspect
        #expect(item).to be
      end
    end
  end
end