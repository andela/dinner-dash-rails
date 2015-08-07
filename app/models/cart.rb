class Cart
	attr_reader :cart_data
	
	def initialize(cart_data)
    @cart_data = cart_data || {}
	end

	def increment(item_id)
	  @cart_data[item_id] ||= 0
	  increment_cart_item_by_one(item_id)
	end

	def destroy
	  @cart_data = nil
	end

	private

	def increment_cart_item_by_one(item_id)
	  @cart_data[item_id] += 1
	end
end
