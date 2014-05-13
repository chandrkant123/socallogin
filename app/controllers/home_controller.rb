class HomeController < ApplicationController
  def index
  end
  def update
  	
  	@user=User.find(params[:user][:id])
  	@user.update_attributes(params[:user]);
  	sign_in_and_redirect @user, :event => :authentication
  end
end
