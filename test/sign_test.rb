require 'test_helper'

class AlipayMobile::SignTest < Test::Unit::TestCase
  def setup
    @params = {
      :service => 'test',
      :partner => '123'
    }
    @sign = Digest::MD5.hexdigest("partner=123&service=test#{AlipayMobile.key}")
  end

  def test_generate_sign
    assert_equal @sign, AlipayMobile::Sign.generate(@params)
  end

  def test_verify_sign
    assert AlipayMobile::Sign.verify?(@params.merge(:sign => @sign))
  end

  def test_verify_sign_when_fails
    assert !AlipayMobile::Sign.verify?(@params.merge(:danger => 'danger', :sign => @sign))
  end
end
