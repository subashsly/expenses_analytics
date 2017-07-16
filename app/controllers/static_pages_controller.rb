class StaticPagesController < ApplicationController
  def home
  	redirect_to(member_path(session[:member_id])) if session[:member_id]!=nil
  end

  def help
  end

  def about
  end

  def contact
  end
end
