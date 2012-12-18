smart-mobile
============

#Smart Mobile API

A ruby gem for consuming Smart Mobile API (currently supports SMS only).

## Requirements

    Ruby 1.9.x

## Installation

    $ gem install smart-mobile

## Configuration
The configuration below will be provided by Smart Devnet. Apply for access (http://www.smart.com.ph/developer)
  
    client = Smart::REST::Client.configure do |config|
      config.sp_id = '<sp_id>'
      config.sp_password = '<sp_encrypted_password>'
      config.service_id = '<service_id>'
      config.access_code = '<access_code>'
      config.path_to_cert = '<path_to_cert>'
      config.creation_time = '<creation_time>'
      config.nonce = '<nonce>'
    end

## Sending SMS

  response = client.send_sms(number, message)
  
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## MIT Open Source License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Acknowledgements

Authored by: <a href="http://iantusil.com" target="_blank">Ian Bert Tusil</a>