class UserMailer < ApplicationMailer

  default :from => "dinnerdashcafe@gmail.com"

  def welcome_email(user)
    @user = user
    attachments.inline['logo3.png'] = File.read("app/assets/images/logo3.png")
    mail(:to => @user.email, :subject => "Welcome to Dinner Dash Cafe")
  end

  def order_email(user, items)
    @current_order = items
    @user = user
    @order = @user.orders.last.id
    attachments.inline['logo3.png'] = File.read("app/assets/images/logo3.png")
    mail(:to => @user.email, :subject => "Your order:#{@order} is being processed")
  end

  def status_email(order)
    @order = order
    @status = @order.Status
    @user = User.find(@order.user_id)
    attachments.inline['logo3.png'] = File.read("app/assets/images/logo3.png")
    mail(:to => @user.email, :subject => "Your order:#{@order.id} is now #{@status}")
  end

end
  
  
  
  