require 'minitest/autorun'
require_relative './../lib/YSDecrypt'

class YSDecryptTest < Minitest::Test

  def setup
  	@d=YSDecrypt.new('./private.key', 'encrypted')
  end

  def test_decrypt
      assert_equal("abc\n" ,@d.decrypt)
  end

  def teardown
    ['./private.key', './public.key', './encrypted'].each do |temp|
      File.delete temp if File.exist?(temp)
    end
  end

end

=begin
openssl genrsa -out private.key 8192
chmod 400 private.key

openssl rsa -in private.key -pubout -out public.key

echo a > plain.txt
openssl rsautl -encrypt -pubin -inkey public.key -in plain.txt -out encrypted

#openssl rsautl -decrypt -inkey private.key -in encrypted -out decrypted.txt
=end
