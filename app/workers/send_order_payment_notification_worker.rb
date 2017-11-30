class SendOrderPaymentNotificationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :mailer

  def perform(order)
    OrderMailer.payment_reminder_email(order.user).deliver! unless order.payment_status == "pending"
  end
end
