class Current_Order
  attr_accessor :ordered_items
  attr_accessor :total
  attr_accessor :delivery_cost
  attr_accessor :sub_total

  def initialize(current_order)
    @ordered_items = current_order["items"] || {}
    current_order["details"] ||= {}
    @total = current_order["details"]["total"].to_i || 0
    @delivery_cost = 500
    @sub_total = current_order["details"]["sub_total"].to_i || 0
    @user = {}
    @invoice = ""
    @transaction_id = ""
    @status = "pending"
  end

  def vat
    0.1 * @sub_total
  end

  def update_order(order, args)
    @ordered_items = order["items"] || {}
    @total = order["details"]["total"] || 0
    @invoice = args[:invoice] || ""
    @transaction_id = args[:transaction_id] || ""
    @status = args[:status] || "pending"
  end

  def paypal_url(current_user, return_url)
    @user = current_user
		values = {
			:business => 'tru2cent-facilitator@gmail.com',
			:cmd => '_cart',
			:upload => 1,
      :rm => 2,
			:return => return_url,
			# :invoice => 15,
      :notify_url => @user.email,
      "amount_#{@ordered_items.length+1}" => vat,
      "item_name_#{@ordered_items.length+1}" => "VAT",
      "amount_#{@ordered_items.length+2}" => @delivery_cost,
      "item_name_#{@ordered_items.length+2}" => "Delivery cost"
		}
    counter = 1
		@ordered_items.each do |index, details|
			values.merge!({
				"amount_#{counter}" => details["food"]["price"],
				"item_name_#{counter}" => details["food"]["name"],
				"item_number_#{counter}" => counter,
				"quantity_#{counter}" => details["qty"]
			})
      counter += 1
		end
    # "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
    # "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.map{ |k, v| "#{k}=#{v}" }.join("&")
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
	end

  def save_order(current_user)
    user = current_user
    require 'pry-nav'; binding.pry
    new_order = user.orders.new(:total => @total, :vat => vat, :delivery_cost => @delivery_cost, :invoice => @invoice, :Status => @status, :transaction_id => @transaction_id)
    save_successful = new_order.save
    if save_successful
      @ordered_items.each do |index, details|
        new_order.order_items << OrderItem.create(:food_id => details["food"]["id"], :quantity => details["qty"])
      end
    end
    save_successful
  end

  def delete

  end

  private

end
