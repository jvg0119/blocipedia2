class ChargesController < ApplicationController
	before_action :authenticate_user! 
	before_action :set_amount
	before_action :set_description
	# Creates a Stripe Customer object, for associating
  # with the charge
	def create
		customer = Stripe::Customer.create(
			email: current_user.email, 
			card: params[:stripeToken]
			)

		# Where the real magic happens
		charge = Stripe::Charge.create(
			customer: customer.id,
			amount: @amount, #10_00, #Amount.default
			description: @description,  #"Blocipedia premium account membership",
			currency: 'usd'
			)

		current_user.update_attribute(:role, "premium")
		flash[:notice] = "Thanks for becoming a Blocipedia premium member #{current_user.name}!"
		redirect_to user_path(current_user) # or wherever 

		# Stripe will send back CardErrors, with friendly messages
		# when something goes wrong.
		# This `rescue block` catches and displays those errors.
		rescue Stripe::CardError => e 
			flash[:alert] = e.message 
			redirect_to new_charge_path 
	end

	def new
		@stripe_btn_data = {	
			key: "#{ Rails.configuration.stripe[:publishable_key] }",
			description: @description, # "Blocipedia premium account membership",
			amount: @amount # 10_00 #Amount.default
		}
	end

	def downgrade
		current_user.update_attribute(:role, "standard")
		current_user.wikis.where(private: true).each do |wiki| 
			wiki.update_attribute(:private, false)
		end
		flash[:notice] = "You are now downgraded back to standard user (#{current_user.name})."
		redirect_to root_url		
	end

private 
	def set_amount
		@amount = 1000
	end
	def set_description
		@description = "Blocipedia premium account membership"
	end

end




