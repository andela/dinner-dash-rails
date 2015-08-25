class Current_Order
  attr_accessor :ordered_items
  attr_accessor :total
  attr_accessor :delivery_cost
  attr_accessor :sub_total

  def initialize(current_order)
    @ordered_items = current_order || {}
    @total = 0
    @delivery_cost = 500
    @sub_total = 0
  end

  def vat
    0.1 * @sub_total
  end

  def update_order(ordered_items, args)
    @ordered_items = ordered_items || {}
    @total = args["total"] || 0
    @delivery_cost = args["delivery_cost"] || 0
  end

  def paypal_url(return_url)
		values = {
			:business => 'tru2cent-facilitator@gmail.com',
			:cmd => '_cart',
			:upload => 1,
			:return => return_url,
			:invoice => id
		}
		@ordered_items.each do |index, ordered_item|
			values.merge!({
				"amount_#{index+1}" => ordered_item[index][:amount],
				"item_name_#{index+1}" => ordered_item[index][:food],
				"item_number_#{index+1}" => ordered_item[index][:food_id],
				"quantity_#{index+1}" => ordered_item[index][:quantity]
			})
		end
	end

  def save_order(current_user)
    user = current_user
    new_order = user.orders.new(:total => @total, :vat => vat, :delivery_cost => @delivery_cost)
    save_successful = new_order.save
    if save_successful
      @ordered_items.each do |food_id, ordered_item|
        new_order.order_items << OrderItem.create(:food_id => ordered_item[0]["id"], :quantity => ordered_item[1])
      end
    end
    save_successful
  end

  def delete

  end

  private

end
