require "spec_helper"

class EncryptedTypeDummy
  include Xmlenc::Builder::ComplexTypes::EncryptedType

  tag "EncryptedKey"
end

describe Xmlenc::Builder::ComplexTypes::EncryptedType do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { EncryptedTypeDummy.new.parse(xml, single: true) }

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
    it "should create a collection of EncryptionMethod" do
      expect(subject.encryption_method).to be_an Array
      expect(subject.encryption_method.first).to be_an Xmlenc::Builder::EncryptionMethod
    end

    it "should create a collection of KeyInfo" do
      expect(subject.key_info).to be_an Array
      expect(subject.key_info.first).to be_a Xmlenc::Builder::KeyInfo
    end

    it "should create a collection of CipherData" do
      expect(subject.cipher_data).to be_an Array
      expect(subject.cipher_data.first).to be_a Xmlenc::Builder::CipherData
    end
  end
end
