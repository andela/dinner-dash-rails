module ApplicationHelper
  def items_in_cart
    items = 0
    if !session[:cart].nil? || session[:cart].length > 0
      session[:cart].each do |_key, value|
        items += value
      end
    end
    items
  end
end
