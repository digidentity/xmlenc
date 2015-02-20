require "spec_helper"

describe Xmlenc::Builder::EncryptionMethod do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { described_class.parse(xml, :single => true) }

  describe "required fields" do
    it "should have the algorithm field" do
      expect(subject).to respond_to :algorithm
    end

    it "should check the presence of algorithm" do
      subject.algorithm = nil
      expect(subject).to have(1).error_on :algorithm
    end
  end

  describe "#parse" do
    it "should create an EncryptionMethod" do
      expect(subject).to be_a Xmlenc::Builder::EncryptionMethod
    end

    it "should parse the algorithm" do
      expect(subject.algorithm).to eq "http://www.w3.org/2001/04/xmlenc#aes128-cbc"
    end
  end

end
