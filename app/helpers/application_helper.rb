module ApplicationHelper
  def items_in_cart
    items = 0
    if !session[:cart].nil? && session[:cart].length > 0
      session[:cart].each do |_key, value|
        items += value
      end
    end
    items
  end

	def this_food_in_cart(food)
		food_count = 0
		if !session.nil? && !session[:cart].nil?
			food_count = session[:cart][food.id.to_s].nil? ? 0 : session[:cart][food.id.to_s]
		end
	end

  def cart_properties
    cart_properties = {}
    if session[:cart].nil? || session[:cart].empty?
    	cart_properties["items_count"] = 0;
    	cart_properties["status"] = "empty";
    else
    	cart_properties["items_count"] = items_in_cart;
    	cart_properties["status"] = "not-empty";
    end
    cart_properties
  end

  def options_for_status
    ['Completed', 'Cancelled', 'Pending', 'Delivered']
  end

  def load_current_order
    @current_order ||= Current_Order.new(session[:order])
  end

end
