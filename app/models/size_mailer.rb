class SizeMailer < ActionMailer::Base
  def caroline(size_chart)
    @subject = "New Size Chart #{size_chart.reference} created"
    @body = { :size_chart => size_chart }
    @recipients = [ "caroline.davis@fimexltd.com"]
    @from = "order_mailer@fimexltd.com"
    @sent_on = Time.now
  end
end