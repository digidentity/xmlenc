require "spec_helper"

describe Xmlenc::Builder::EncryptedData do

  let(:xml) { File.read File.join("spec", "fixtures", "template.xml") }
  subject   { described_class.parse(xml, single: true) }

  #tijdelijk voor assertion testing
  let(:assertion_xml) {File.read File.join("spec", "fixtures", "assertion.xml") }

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

  describe "from assertion" do
    it "is should work!" do
      raw_cert = <<-CERT
        MIICgjCCAeugAwIBAgIBADANBgkqhkiG9w0BAQUFADA6MQswCQYDVQQGEwJCRTEN
        MAsGA1UECgwEVGVzdDENMAsGA1UECwwEVGVzdDENMAsGA1UEAwwEVGVzdDAeFw0x
        MzAxMTQxMzM5NTBaFw0xNDAxMTQxMzM5NTBaMDoxCzAJBgNVBAYTAkJFMQ0wCwYD
        VQQKDARUZXN0MQ0wCwYDVQQLDARUZXN0MQ0wCwYDVQQDDARUZXN0MIGfMA0GCSqG
        SIb3DQEBAQUAA4GNADCBiQKBgQDgJhsC/EH+FebE7OfgwWyQgSxXiY4i5XMj/U+M
        JUsZ1O2jb70aMkb3hwXKGPWBV0fHHKkdeugchxKx/973fvrkgiYWiy3j6yUyBzSg
        WoCKcZGZEng5cgA9L/6roVkpnjNCYc49PQYa68+cLy419ooWSEYnTFlDpUiShvil
        jEWT6wIDAQABo4GXMIGUMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFBJIbgZX
        Unf4On2C9KiGNrvcBXvvMGIGA1UdIwRbMFmAFBJIbgZXUnf4On2C9KiGNrvcBXvv
        oT6kPDA6MQswCQYDVQQGEwJCRTENMAsGA1UECgwEVGVzdDENMAsGA1UECwwEVGVz
        dDENMAsGA1UEAwwEVGVzdIIBADANBgkqhkiG9w0BAQUFAAOBgQDJcmmrA4y1K/TL
        MLA/zWf90snZubfCFC1iR3gBSKi5v49OxM4vkZSLo9gQfUJGwohPqld/PB6B1o1g
        pHEcbxWEgFnL+3irPcNLpcXPLNvbpzHjCOhVvRHIwIw+ZwlWir1yQKYcNXIPUFRq
        dRRsAwyOT8Qv3yGWNPYzNQ16qzPYJg==
      CERT

      certificate   = OpenSSL::X509::Certificate.new(Base64.decode64(raw_cert))
      symmetric_key = subject.encrypt(assertion_xml)

      encrypted_key = subject.key_info.encrypted_key

      encrypted_key.encrypt(certificate.public_key, symmetric_key)

      puts subject.to_xml
    end
  end

  describe "#parse" do
    it "should create an EncryptedData element" do
      expect(subject).to be_a Xmlenc::Builder::EncryptedData
    end

    it "should parse the id" do
      expect(subject.id).to eq "ED"
    end

    it "should parse the type" do
      expect(subject.type).to eq "http://www.w3.org/2001/04/xmlenc#Element"
    end

    describe "encryption method" do
      it "should create an EncryptionMethod element" do
        expect(subject.encryption_method).to be_a Xmlenc::Builder::EncryptionMethod
      end

      it "should parse the algorithm" do
        expect(subject.encryption_method.algorithm).to eq "http://www.w3.org/2001/04/xmlenc#aes128-cbc"
      end
    end

    describe "key info" do
      it "should create a KeyInfo element" do
        expect(subject.key_info).to be_a Xmlenc::Builder::KeyInfo
      end
    end

    describe "cipher data" do
      it "should create a CipherData element" do
        expect(subject.cipher_data).to be_a Xmlenc::Builder::CipherData
      end

      let(:cipher_value) { subject.cipher_data.cipher_value.gsub(/[\n\s]/, "") }

      it "should parse the cipher value" do
        expect(cipher_value).to eq "u2vogkwlvFqeknJ0lYTBZkWS/eX8LR1fDPFMfyK1/UY0EyZfHvbONfDHcC/HLv/faAOOO2Y0GqsknP0LYT1OznkiJrzx134cmJCgbyrYXd3Mp21Pq3rs66JJ34Qt3/+IEyJBUSMT8TdT3fBD44BtOqH2op/hy2g3hQPFZul4GiHBEnNJL/4nU1yad3bMvtABmzhx80lJvPGLcruj5V77WMvkvZfoeEqMq4qPWK02ZURsJsq0iZcJDi39NB7OCiON"
      end
    end
  end
end
