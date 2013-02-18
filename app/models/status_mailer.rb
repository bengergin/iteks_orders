class StatusMailer < ActionMailer::Base
  
  def factory(order, factory_id, user_id, description)
    factory = Factory.find(factory_id)
    user = User.find(user_id)
    
    @subject = "Order #{order.reference} placed in #{factory.name} by #{user.name}."
    @body = { :order => order, :factory => factory, :user => user, :description => description }
    @recipients = [order.user.email, "emre.icel@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
  
  def profit(order, factory_id, user_id, description)
    factory = Factory.find(factory_id)
    user = User.find(user_id)
    
    @subject = "Order #{order.reference} placed in #{factory.name} by #{user.name}."
    @body = { :order => order, :factory => factory, :user => user, :description => description }
    @recipients = ["adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com", "alison.rhodes@fimexltd.com","directors@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
  
  def quality(order, user_id, factory_id, description, qc)
    factory = Factory.find(factory_id)
    user = User.find(user_id)
    @subject = "Order #{order.reference} has recorded the quality report as #{order.qc} by #{user.name}."
    @body = { :order => order, :factory => factory, :user => user, :description => description }
    @recipients = ["adrian.dobbs@fimexltd.com", "caroline.davis@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
end
