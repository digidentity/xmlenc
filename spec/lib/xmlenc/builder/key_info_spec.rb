require "spec_helper"

describe Xmlenc::Builder::KeyInfo do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { described_class.parse(xml) }

  describe "#parse" do
    it "should create two KeyInfo elements" do
      subject.each do |element|
        expect(element).to be_a Xmlenc::Builder::KeyInfo
      end

      expect(subject.size).to eq 2
    end

    describe "key name" do
      it "doesn't have a key name in the first key info element" do
        expect(subject.first.key_name).to be_nil
      end

      it "should parse the key name in the second key info element" do
        expect(subject.last.key_name).to eq "my-rsa-key"
      end
    end

    describe "encrypted key" do
      it "should parse the encrypted key in the first key info element" do
        expect(subject.first.encrypted_key).to be_a Xmlenc::Builder::EncryptedKey
      end

      it "doesn't have an encrypted key in the second key info element" do
        expect(subject.last.encrypted_key).to be_nil
      end
    end
  end

end
