class UserMailer < ApplicationMailer

  default :from => "alex.obogbare@andela.com"

  def attachments
    attachments.inline['logo3.png'] = File.read(Rails.root.join("app", "assets", "images", "logo3.png"))
  end

  def welcome_email(user)
    @user = user
    mail(:to => @user.email, :subject => "Welcome to Dinner Dash Cafe")
    attachments
  end

  def order_email(user, items)
    @current_order = items
    @user = user
    mail(:to => @user.email, :subject => "Your order#{@current_order.id} is been processed")
    attachments
  end

  def status_email(order)
    @order = order
    @status = @order.Status
    @user = User.find(@order.user_id)
    mail(:to => @user.email, :subject => "Your order:#{@order.id} is now #{@status}")
    attachments
  end

end
  
  
  
  