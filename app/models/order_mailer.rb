class OrderMailer < ActionMailer::Base
  def turkey(order)
    @subject = "New Order #{order.reference} To Be Placed"
    @body = { :order => order }
    @recipients = ["adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com", "emre.icel@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end

  def elsewhere(order)
    @subject = "New Order #{order.reference} To Be Placed"
    @body = { :order => order }
    @recipients = ["adam.duan@fimexltd.com", "jing.yang@fimexltd.com", "adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
end