class RemindersController < ApplicationController

	def index
		@reminders = Reminder.all
		# @reminders = current_member.reminders.paginate(:page => 1, :per_page => 2)
		# redirect_to member_path(id: current_member.id)
	end

	def show
		@reminder = Reminder.find(params[:id])
	end

	def new
		@reminder = Reminder.new
	end

	def edit
		@reminder = Reminder.find(params[:id])
	end

	def update
		@reminders = current_member.reminders
		@reminder = Reminder.find(params[:id])

		if @reminder.update_attributes(reminder_params)
			redirect_to member_path(id: current_member.id)
		else
			render 'edit'
		end
	end


	def create
		@reminder = Reminder.new(reminder_params.merge(member_id: current_member.id))
		if @reminder.save
			flash[:info] = "Reminder has been added."
			redirect_to member_path(id: current_member.id)
		else
			render 'new'
		end
	end

	def destroy
		@reminder = Reminder.find(params[:id])
		@reminder.destroy
		redirect_to member_path(id: current_member.id)
	end

	private
		def reminder_params	
			params.require(:reminder).permit(:title, :amount, :description, :date_notify, :member_id)
		end
end
