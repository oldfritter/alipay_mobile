require 'digest/md5'

module AlipayMobile
  module Sign
    def self.generate(params)
      query = params.sort.map do |key, value|
        "#{key}=#{value}"
      end.join('&')

      Digest::MD5.hexdigest "#{query}#{AlipayMobile.key}"
    end

    def self.verify?(params)
      params = Utils.stringify_keys(params)
      params.delete('sign_type')
      sign = params.delete('sign')

      generate(params) == sign
    end
  end
end
