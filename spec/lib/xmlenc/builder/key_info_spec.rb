require "spec_helper"

describe Xmlenc::Builder::KeyInfo do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_key.xml") }
  subject   { described_class.parse(xml, single: true) }

  describe "#parse" do
    it "should create a KeyInfo" do
      expect(subject).to be_a Xmlenc::Builder::KeyInfo
    end

    it "should parse the key name" do
      expect(subject.key_name).to eq "my-rsa-key"
    end

    describe "encrypted key" do
      let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }

      it "should parse the encrypted key" do
        expect(subject.encrypted_key).to be_a Xmlenc::Builder::EncryptedKey
      end
    end
  end

end
