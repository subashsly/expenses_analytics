class AccountActivationsController < ApplicationController

	def edit
		member = Member.find_by(member_email: params[:member_email])
		if member && !member.activated? && member.authenticated?(:activation, params[:id])
			member.activate
			flash[:success] = "Account activated"
			log_in member 
			redirect_to member 
		else
			flash[:danger] = "Invalid activation link."
			redirect_to root_url
		end
	end	
end