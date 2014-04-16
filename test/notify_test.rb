require 'test_helper'

class AlipayMobile::NotifyTest < Test::Unit::TestCase
  def setup
    @options = {
      :notify_id => '1234'
    }
    @sign_options = @options.merge(:sign_type => 'MD5', :sign => AlipayMobile::Sign.generate(@options))
  end

  def test_unsign_notify
    FakeWeb.register_uri(:get, "https://mapi.alipay.com/gateway.do?service=notify_verify&partner=#{AlipayMobile.pid}&notify_id=1234", :body => "true")
    assert !AlipayMobile::Notify.verify?(@options)
  end

  def test_verify_notify_when_true
    FakeWeb.register_uri(:get, "https://mapi.alipay.com/gateway.do?service=notify_verify&partner=#{AlipayMobile.pid}&notify_id=1234", :body => "true")
    assert AlipayMobile::Notify.verify?(@sign_options)
  end

  def test_verify_notify_when_false
    FakeWeb.register_uri(:get, "https://mapi.alipay.com/gateway.do?service=notify_verify&partner=#{AlipayMobile.pid}&notify_id=1234", :body => "false")
    assert !AlipayMobile::Notify.verify?(@sign_options)
  end
end
