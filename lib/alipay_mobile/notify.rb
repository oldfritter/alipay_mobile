module AlipayMobile
  class Notify
    
    class << self
      def generate(params)
        query = []
        ['service', 'v', 'sec_id', 'notify_data'].each {|key| query << "#{key}=#{params[key]}" }
        Digest::MD5.hexdigest "#{query.join('&')}#{AlipayMobile.key}"
      end

      def verify?(params)
        params = Utils.stringify_keys(params)
        params.delete('sign_type')
        sign = params.delete('sign')

        generate(params) == sign
      end
    end
    

  end
end
