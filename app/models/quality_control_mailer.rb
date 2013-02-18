class QualityControlMailer < ActionMailer::Base
  
  def report(quality_control)
  	if quality_control.order.country_id == 73667960 
  		if quality_control.pass_fail == true
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "emre.icel@fimexltd.com", "adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com"]
    		from "order_mailer@fimexltd.com"
    		sent_on Time.now
    	else
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "emre.icel@fimexltd.com", "adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com"]
    		from "order_mailer@fimexltd.com"
    		sent_on Time.now
    	end
    else
  		if quality_control.pass_fail == true
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "jing.yang@fimexltd.com", "adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com"]
    		from "order_mailer@fimexltd.com"
    		sent_on Time.now
    	else
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "jing.yang@fimexltd.com", "adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com"]
    		from "order_mailer@fimexltd.com"
    		sent_on Time.now
    	end
    end
  end
end
