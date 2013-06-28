class OrderMailer < ActionMailer::Base
  def turkey(order)
    @subject = "New Order #{order.reference} To Be Placed"
    @body = { :order => order }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@i-teks.com.tr", "emre.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end

  def elsewhere(order)
    @subject = "New Order #{order.reference} To Be Placed"
    @body = { :order => order }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "emil.icel@fimexltd.com", "adam.duan@fimexltd.com", "jing.yang@fimexltd.com"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
end