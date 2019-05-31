class Transaction < ApplicationRecord
  #extend WebpayRails

  #webpay_rails(
   # commerce_code: 123456789,
    #private_key: '-----BEGIN RSA PRIVATE KEY-----,
    #public_cert: ,
    #webpay_cert: '-----BEGIN CERTIFICATE-----,
    #environment: :integration,
    #log: true
  #)
  belongs_to :user
  belongs_to :polla
end
