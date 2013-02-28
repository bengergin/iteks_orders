class SizeMailer < ActionMailer::Base
  def caroline(size_chart)
    @subject = "New Size Chart #{size_chart.reference} created"
    @body = { :size_chart => size_chart }
    @recipients = [ "caroline.davis@fimexltd.com", "eren.icel@i-teks.com.tr"]
    @from = "order.mailer.iteks@gmail.com"
    @sent_on = Time.now
  end
end