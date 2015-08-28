class OrderWorker
  include Sidekiq::Worker

  def perform(user_id, order)
    @user = User.find(user_id)
    UserMailer.order_email(@user, order).deliver_now
  end
end
