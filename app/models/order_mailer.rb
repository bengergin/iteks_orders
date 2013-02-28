class OrderMailer < ActionMailer::Base
  def email(order)
    @subject = "New Order #{order.reference} To Be Placed"
    @body = { :order => order }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
end