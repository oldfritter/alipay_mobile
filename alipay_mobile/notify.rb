module AlipayMobile
  class Notify
    def self.verify?(params)
      if Sign.verify?(params)
        params = Utils.stringify_keys(params)
        open("https://mapi.alipay.com/gateway.do?service=notify_verify&partner=#{AlipayMobile.pid}&notify_id=#{CGI.escape params['notify_id'].to_s}").read == 'true'
      else
        false
      end
    end
  end
end
