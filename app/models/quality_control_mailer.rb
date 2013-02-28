class QualityControlMailer < ActionMailer::Base
  
  def report(quality_control)
  	if quality_control.order.country_id == 73667960 
  		if quality_control.pass_fail == true
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    		from "order.mailer.iteks@gmail.com"
    		sent_on Time.now
    	else
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    		from "order.mailer.iteks@gmail.com"
    		sent_on Time.now
    	end
    else
  		if quality_control.pass_fail == true
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    		from "order.mailer.iteks@gmail.com"
    		sent_on Time.now
    	else
    		subject  "Quality Control #{quality_control.id} - #{quality_control.pass_or_fail}"
    		body  :quality_control => quality_control
    		recipients [quality_control.order.user.email, "adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    		from "order.mailer.iteks@gmail.com"
    		sent_on Time.now
    	end
    end
  end
end
