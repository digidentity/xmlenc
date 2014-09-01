require 'spec_helper'

describe Xmlenc::EncryptedDocument do
  let(:plain_xml) { File.read('spec/fixtures/phaos/payment.xml') }
  let(:encrypted_xml) { File.read('spec/fixtures/encrypted_document.xml') }
  let(:private_key) { OpenSSL::PKey::RSA.new(File.read('spec/fixtures/phaos/rsa-priv-key.pem')) }
  subject { described_class.new(encrypted_xml) }

  describe 'document' do
    it 'returns the nokogiri document' do
      expect(subject.document).to be_a(Nokogiri::XML::Document)
    end

    it 'raises on badly formed XML' do
      badly_formed = <<-EOXML
      <root>
        <open>foo
          <closed>bar</closed>
      </root>
      EOXML
      expect {
        described_class.new(badly_formed).document
      }.to raise_error
    end
  end

  describe 'encrypted_keys' do
    it 'returns the encrypted keys' do
      expect(subject.encrypted_keys.count).to be == 1
    end

    it 'converts the elements to EncryptedKey' do
      all_converted = subject.encrypted_keys.all? { |ek| ek.is_a?(Xmlenc::EncryptedKey) }
      expect(all_converted).to be_true
    end
  end

  describe 'decrypt' do
    it 'replaces the encrypted data with the unencrypted elements' do
      expect(subject.decrypt(private_key).chomp).to be == plain_xml
    end
  end
end
