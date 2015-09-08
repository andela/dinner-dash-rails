class StatusWorker
  include Sidekiq::Worker

  def perform(order)
    @order = Order.find(@order_id)
    UserMailer.status_email(@order).deliver_now
  end
end