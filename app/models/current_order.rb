class Current_Order
  attr_accessor :ordered_items
  attr_accessor :total
  attr_accessor :delivery_cost
  attr_accessor :sub_total

  def initialize
    require 'pry-nav';binding.pry
    @ordered_items ||= {}
    @total ||= 0
    @delivery_cost ||= 500
    @sub_total ||= 0
  end

  def vat
    0.1 * @sub_total
  end

  def save_order(current_user)
    user = current_user
    require 'pry-nav';binding.pry
    new_order = user.orders.new(:total => @total, :vat => vat, :delivery_cost => @delivery_cost)
    save_successful = new_order.save
    if save_successful
      @ordered_items.each do |food, qty|
        new_order.order_items << Order_Items.create(:food_id => food["id"], :quantity => qty)
      end
    end
    save_successful
  end

  def delete

  end 

  private

end
