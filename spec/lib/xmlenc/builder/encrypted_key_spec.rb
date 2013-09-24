require "spec_helper"

describe Xmlenc::Builder::EncryptedKey do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { described_class.parse(xml, single: true) }

  describe "#parse" do
    it "should create an EncryptedKey" do
      expect(subject).to be_a Xmlenc::Builder::EncryptedKey
    end
  end

end
