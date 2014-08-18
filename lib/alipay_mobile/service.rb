require 'cgi'
require 'open-uri'

module AlipayMobile
  module Service
    MOBILE_GATEWAY_URL = 'http://wappaygw.alipay.com/service/rest.htm'
    
    GET_MOBILE_WEB_INSTANT_CREDIT_AUTHORIZATION_TOKEN = %w( service partner _input_charset req_data )
    # AlipayMobile mobile Web instant credit authorization
    def self.mobile_web_instant_credit_authorization(options={})
      options = {
        'service'        => 'alipay.wap.trade.create.direct',
        '_input_charset' => 'utf-8',
        'partner'        => AlipayMobile.pid
      }.merge(Utils.stringify_keys(options))

      check_required_options(options, GET_MOBILE_WEB_INSTANT_CREDIT_AUTHORIZATION_TOKEN)

      "#{MOBILE_GATEWAY_URL}?#{query_string(options)}"
      
    end
    
    MOBILE_WEB_INSTANT_CREDIT_TRANSACTION_OPTION = %w( service partner _input_charset req_data )
    # AlipayMobile mobile web instant credit transaction
    def self.mobile_web_instant_credit_transaction_url(options={})
      options = {
        'service'        => 'alipay.wap.auth.authAndExecute',
        '_input_charset' => 'utf-8',
        'partner'        => AlipayMobile.pid,
        'seller_email'   => AlipayMobile.seller_email
      }.merge(Utils.stringify_keys(options))

      check_required_options(options, MOBILE_WEB_INSTANT_CREDIT_TRANSACTION_OPTION)

      "#{MOBILE_GATEWAY_URL}?#{query_string(options)}"
      
    end
    
    def self.query_string(options)
      query = options.sort.concat([['sign', AlipayMobile::Sign.generate(options)]]).map do |key, value|
        "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
      end.join('&')
    end

    def self.check_required_options(options, names)
      names.each do |name|
        warn("AlipayMobile Warn: missing required option: #{name}") unless options.has_key?(name)
      end
    end
  end
end
