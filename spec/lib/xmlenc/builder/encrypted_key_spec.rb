require "spec_helper"

describe Xmlenc::Builder::EncryptedKey do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { described_class.parse(xml, single: true) }

  describe "required fields" do
    it "should have the cipher data field" do
      expect(subject).to respond_to :cipher_data
    end

    it "should check the presence of cipher data" do
      subject.cipher_data = nil
      expect(subject).to have(1).error_on :cipher_data
    end
  end

  describe "optional fields" do
    [:encryption_method, :key_info].each do |field|
      it "should have the #{field} field" do
        expect(subject).to respond_to field
      end

      it "should allow #{field} to be blank" do
        subject.send("#{field}=", nil)
        expect(subject).to be_valid
      end
    end
  end

  describe "#parse" do
    it "should create an EncryptedKey" do
      expect(subject).to be_a Xmlenc::Builder::EncryptedKey
    end
  end

end
