class SampleMailer < ActionMailer::Base
  def turkey(sample)
    @subject = "New Sample #{sample.reference} To Be Made"
    @body = { :sample => sample }
    @recipients = ["adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr", "kemal.iyisan@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end

  def elsewhere(sample)
    @subject = "New Sample #{sample.reference} To Be Made"
    @body = { :sample => sample }
    @recipients = ["adam.duan@fimexltd.com", "jing.yang@fimexltd.com", "adrian.dobbs@i-teks.com.tr", "caroline.davis@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
  def price(sample)
    @subject = "New Price #{sample.reference} has been submitted"
    @body = { :sample => sample }
    @recipients = ["caroline.davis@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
  
end