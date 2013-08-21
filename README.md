# Xmlenc

This gem is a (partial) implementation of the XMLEncryption specification (http://www.w3.org/TR/xmlenc-core/)

## Installation

Add this line to your application's Gemfile:

    gem 'xmlenc'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xmlenc

## Usage

### Decrypt a document

```ruby
  key_pem = File.read('path/to/key.pem')
  xml = File.read('path/to/file.xml')

  private_key = OpenSSL::PKey::RSA.new(key_pem)
  decrypted_document = Xmlenc::EncryptedDocument.decrypt(private_key)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
