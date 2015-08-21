class AdminController < ApplicationController
	def foods
    @foods = Food.all.order(created_at: :desc)
	end
end
