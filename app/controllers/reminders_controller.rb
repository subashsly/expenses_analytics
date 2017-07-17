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
		@reminders = current_member.reminders
  		@reminder = Reminder.create(reminder_params.merge(member_id: current_member.id))
	end

	def delete
  	@reminder = Reminder.find(params[:reminder_id])
  end

  def destroy
  	@reminders = current_member.reminders
  	@reminder = Reminder.find(params[:id])
  	@reminder.destroy
  end

	private
		def reminder_params	
			params.require(:reminder).permit(:title, :amount, :description, :date_notify, :member_id).merge(member_id: current_member.id)
		end
end
