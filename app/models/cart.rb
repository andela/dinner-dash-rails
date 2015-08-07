class Cart < ActiveRecord::Base
	attr_reader :data

	def initialize(cart_data)
		@cart_data = cart_data || {}
	end

	def update(item_id)
		@cart_data[:item_id] ||= 0
		@cart_data[:item_id] += 1
	end

	def destroy!
		@cart_data = nil
	end

	def data
		@cart_data
	end
end
