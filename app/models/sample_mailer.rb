class SampleMailer < ActionMailer::Base
  def mail(sample)
    @subject = "New Sample #{sample.reference} To Be Made"
    @body = { :sample => sample }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
  def price(sample)
    @subject = "New Price #{sample.reference} has been submitted"
    @body = { :sample => sample }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@fimexltd.com", "eren.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
end