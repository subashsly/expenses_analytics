class MembersController < ApplicationController
  before_action :logged_in_member, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_member, only: [:edit, :update]
  before_action :admin_member, only: :destroy

  def index
    # @members = Member.all
    redirect_to '/' unless current_member.admin?
    @members = Member.all.paginate(page: params[:page])
  end

  def show
    # @income = Member.incomes
    if params[:date]
      if params[:date].to_i ==4 
        
      elsif params[:date].to_i ==1
        @week = "THIS WEEK"
      elsif params[:date].to_i ==2
        @week = "LAST WEEK"
      else
        @week = "LAST MONTH"
      end
      @date = params[:date].to_i.weeks.ago
    else
      @week = "THIS MONTH"
      @date = 4.weeks.ago
    end

    @transaction=(current_member.expenses.all + current_member.incomes.all).sort{|a,b| b.date <=> a.date }
    
    if params[:id] == current_member.id.to_s
      @total = current_member.incomes.sum(:amount) - current_member.expenses.sum(:amount)
      @member = Member.find(params[:id])
      @income = current_member.incomes
      @expense = current_member.expenses
    else
      redirect_to root_url
    end
    # For pagination
    @reminders = current_member.reminders.paginate(:page => 1, :per_page => 2)
  end

  def search
    search =  params[:search]
    @expense=Expense.where('title LIKE ?', "%#{search}%")
    @income=Income.where('title LIKE ?', "%#{search}%")
    @category= Category.where('title LIKE ?', "%#{search}%")
    @search = @expense + @income + @category  
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      @member.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    Member.find(params[:id]).destroy
    flash[:success] = "Member deleted"
    redirect_to members_url
  end

  def edit
    # @member = Member.find(params[:id])
  end

  def update
    # @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      # Handle a successful update.
      flash[:success] = "Profile Updated"
      redirect_to @member
    else
      render 'edit'
    end
  end

  private
    def member_params
      params.require(:member).permit(:member_name, :member_email, :member_country, :password, :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in member.
    def logged_in_member
      unless logged_in?
        store_location
        flash[:danger] = "Please Log In"
        redirect_to login_url
      end
    end

    #Confirms the correct member.
    def correct_member
      @member = Member.find(params[:id])
      redirect_to(root_url) unless current_member?(@member)
    end

    # Confirms an admin member.
    def admin_member
      redirect_to(root_url) unless current_member.admin?
    end
end
