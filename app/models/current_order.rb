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

  def make_payment(notify_url)
		values = {
			:business => 'tru2cent-facilitator@gmail.com',
			:cmd => '_cart',
			:upload => 1,
			:return => payment_completed_path,
			:invoice => id,
      :notify_url => notify_url
      "amount_#{@ordered_item.length+1}" => vat,
      "item_name_#{@ordered_item.length+1}" => "VAT",
      "amount_#{@ordered_item.length+2}" => @delivery_cost,
      "item_name_#{@ordered_item.length+2}" => "Delivery cost"
		}
		@ordered_items.each do |index, ordered_item|
			values.merge!({
				"amount_#{index+1}" => ordered_item[0][:price],
				"item_name_#{index+1}" => ordered_item[0][:name],
				"item_number_#{index+1}" => ordered_item[0][:id],
				"quantity_#{index+1}" => ordered_item[1]
			})
		end
    require 'pry-nav'; binding.pry
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.map{ |k, v| "#{k}=#{v}" }.join("&")
	end

  def paypal_payment_completed
    #  payment_path(:order => { :delivery_cost => @current_order.delivery_cost, :vat => @current_order.vat, :total => @current_order.total })
    #
    args = { :invoice => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id]}
    order_saved = args[:status].downcase === "completed" ? save_order(current_user) : false

    flash[:notice] = "Your payment is #{args[:status]}"
    redirect_to root_path
  end

  def save_order
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
