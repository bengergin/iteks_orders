class StatusMailer < ActionMailer::Base
  
  def factory(order, factory_id, user_id, description)
    factory = Factory.find(factory_id)
    user = User.find(user_id)
    
    @subject = "Order #{order.reference} placed in #{factory.name} by #{user.name}."
    @body = { :order => order, :factory => factory, :user => user, :description => description }
    @recipients = [order.user.email]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
  def profit(order, factory_id, user_id, description)
    factory = Factory.find(factory_id)
    user = User.find(user_id)
    
    @subject = "Order #{order.reference} placed in #{factory.name} by #{user.name}."
    @body = { :order => order, :factory => factory, :user => user, :description => description }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@i-teks.com.tr", "emil.icel@fimexltd.com", "eren.icel@i-teks.com.tr", "ozen.icel@fimexltd.com", "emre.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
  def quality(order, user_id, factory_id, description, qc)
    factory = Factory.find(factory_id)
    user = User.find(user_id)
    @subject = "Order #{order.reference} has recorded the quality report as #{order.qc} by #{user.name}."
    @body = { :order => order, :factory => factory, :user => user, :description => description }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@i-teks.com.tr", "eren.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
  def complete(dispatch, user_id, description)
  	user = User.find(user_id)
  	
    @subject = "Dispatch No. #{dispatch.id} for Order #{dispatch.order.reference} has been complete by #{user.name}."
    @body = { :dispatch => dispatch, :user => user, :description => description }
    @recipients = ["adrian.dobbs@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
end
