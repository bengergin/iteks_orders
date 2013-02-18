class SampleMailer < ActionMailer::Base
  def turkey(sample)
    @subject = "New Sample #{sample.reference} To Be Made"
    @body = { :sample => sample }
    @recipients = ["caroline.davis@fimexltd.com", "emre.icel@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end

  def elsewhere(sample)
    @subject = "New Sample #{sample.reference} To Be Made"
    @body = { :sample => sample }
    @recipients = ["adam.duan@fimexltd.com", "jing.yang@fimexltd.com", "design@fimexltd.com", "caroline.davis@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
  
  def price(sample)
    @subject = "New Price #{sample.reference} has been submitted"
    @body = { :sample => sample }
    @recipients = ["caroline.davis@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
  
end