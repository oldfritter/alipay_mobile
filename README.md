# AlipayMobile 

A simple alipay_mobile ruby gem, without unnecessary magic or wraper, it's directly facing how alipay_mobile api works.



## Installation

Add this line to your application's Gemfile:


```ruby
gem 'alipay_mobile', :git => 'https://github.com/oldfritter/alipay_mobile.git'
```

And then execute:

```sh
$ bundle install
```

## Usage

### Config

```ruby
AlipayMobile.pid = 'YOUR_PID'
AlipayMobile.key = 'YOUR_KEY'
AlipayMobile.seller_email = 'YOUR_SELLER_EMAIL'
```

### Generate payment url

```ruby
options = {req_id: orders.first.payment_sn, format: 'xml', v: '2.0', sec_id: 'MD5'}
options[:req_data] = "<direct_trade_create_req>
<subject>#{order.subject}</subject>
<out_trade_no>#{order.out_trade_no}</out_trade_no>
<total_fee>#{order.order_total_price}</total_fee>
<seller_account_name>#{Alipay.seller_email}</seller_account_name>
<call_back_url>#{call_back_url}</call_back_url>
<notify_url>#{notify_url}</notify_url>
<out_user>#{order.out_user}</out_user>
<merchant_url>#{merchant_url}</merchant_url>
<pay_expire>3600</pay_expire>
<payment_type>1</payment_type>
</direct_trade_create_req>".gsub(/[\r\n]+/,'')

#获取token:
url = AlipayMobile::Service.mobile_web_instant_credit_authorization(options)
@token = open(url) {|resp|return Nokogiri::HTML(URI.unescape resp.read).css('request_token').text}


#交易
options = {
	service: 'alipay.wap.auth.authAndExecute',
	_input_charset: 'utf-8',
	partner: AlipayMobile.pid,
	seller_email: AlipayMobile.seller_email,
	req_id: order.uniq_id, 
	format: 'xml', 
	v: '2.0', 
	sec_id: 'MD5'
}			
options[:req_data] = "<auth_and_execute_req><request_token>#{@token}</request_token></auth_and_execute_req>"
			
payment_url = AlipayMobile::Service.mobile_web_instant_credit_transaction_url(options)
redirect_to payment_url
```

You can redirect user to this payment url, and user will see a payment page for his/her order.

Current support three payment type:
```ruby
 AlipayMobile::Service#mobile_web_instant_credit_authorization	# 手机网页即时到账授权接口
 AlipayMobile::Service#mobile_web_instant_credit_transaction_url 	# 手机网页即时到账交易接口
```

### Verify notify

```ruby
# example in rails
require 'nokogiri'

def alipay_mobile_notify
	return false unless AlipayMobile::Notify.verify? params
	nokogiri = Nokogiri::XML params['notify_data']
	payment_history = PaymentHistory.where(payment_sn: nokogiri.css('out_trade_no').text).first # PaymentHistory is a Model in my project.
	if nokogiri.css('trade_status').text == 'TRADE_FINISHED' || nokogiri.css('trade_status').text == 'TRADE_SUCCESS'
		.....your code....
	end
	render text: 'success' # Here must return 'success'.
end

```

## Contributing

Bug report or pull request are welcome. leon.zcf(at)gmail.com
