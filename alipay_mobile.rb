require "alipay_mobile/version"
require 'alipay_mobile/utils'
require 'alipay_mobile/sign'
require 'alipay_mobile/service'
require 'alipay_mobile/notify'

module AlipayMobileMobile
  class << self
    attr_accessor :pid
    attr_accessor :key
    attr_accessor :seller_email
  end
end
