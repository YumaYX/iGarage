#!/usr/bin/env ruby

require 'openssl'

class YSDecrypt

  attr_accessor :privatekey, :datalocation

  def initialize(privatekey='', datalocation='')
    @privatekey = privatekey
    @datalocation = datalocation
  end

  def decrypt
    rsa = OpenSSL::PKey::RSA.new(open(@privatekey))
    data = open(@datalocation, 'r').read
    rsa.private_decrypt(data)
  end

end
