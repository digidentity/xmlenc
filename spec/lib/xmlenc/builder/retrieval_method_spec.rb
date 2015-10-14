require "spec_helper"

describe Xmlenc::Builder::RetrievalMethod do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { described_class.parse(xml) }

  describe "optional fields" do
    subject { described_class.new }

    [:type, :uri].each do |field|
      it "should have the #{field} field" do
        expect(subject).to respond_to field
      end

      it "should allow #{field} to be blank" do
        subject.send("#{field}=", nil)
        expect(subject).to be_valid
      end
    end
  end
end
