include Rails.application.routes.url_helpers

class OrderMailer < ApplicationMailer
  default from: "hello@shopper.com"

  def shop_owner_order_notification(order)
    @order = order
    @shop_owner = User.where(role: :admin).first
    @payment_status_message = ""
    if order.payment_status == "pending"
      @payment_status_message = "Payment is to be acquired by customer, hold on with delivery!"
    else
      @payment_status_message = "Payment was just processed, the order can be delivered."
    end
    mail(to: @shop_owner.email, subject: "A new order no #{order.id} has been sumitted")
  end

  def payment_reminder_email(user)
    @user = user
    @orders = @user.orders.where(payment_status: "pending")
    mail(to: @user.email, subject: "Kind reminder to proceed with order(s) payment")
  end
end
