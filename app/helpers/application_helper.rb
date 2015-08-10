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
end
