require "./spec_helper"
require "uuid"
require "sodium"
require "base64"
require "http/params"
require "json"
require "http/client"

SECRET = Sodium::Sign::SecretKey.new
PUBO = SECRET.public_key



  # TODO: Write tests

   
    
puts "**"
puts Base64.strict_encode(PUBO.to_slice)
    
