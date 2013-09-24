require "spec_helper"

describe Xmlenc::Builder::CipherData do

  let(:xml) { File.read File.join("spec", "fixtures", "encrypted_document.xml") }
  subject   { described_class.parse(xml, single: true) }

  describe "#parse" do
    it "should create a CipherData" do
      expect(subject).to be_a Xmlenc::Builder::CipherData
    end

    it "should parse the cipher value" do
      expect(subject.cipher_value.gsub(/[\n\s]/, "")).to eq "cCxxYh3xGBTqlXbhmKxWzNMlHeE28E7vPrMyM5V4T+t1Iy2csj1BoQ7cqBjEhqEyEot4WNRYsY7P44mWBKurj2mdWQWgoxHvtITP9AR3JTMxUo3TF5ltW76DLDsEvWlEuZKam0PYj6lYPKd4npUULeZyR/rDRrth/wFIBD8vbQlUsBHapNT9MbQfSKZemOuTUJL9PNgsosySpKrX564oQw398XsxfTFxi4hqbdqzA/CLL418X01hUjIHdyv6XnA298Bmfv9WMPpX05udR4raDv5X8NWxjH00hAhasM3qumxoyCT6mAGfqvE23I+OXtrNlUvE9mMjANw4zweCHsOcfw=="
    end
  end

end
