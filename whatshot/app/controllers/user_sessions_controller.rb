class UserSessionsController < ApplicationController
skip_before_filter :require_login, except: [:destroy]
respond_to :html, :js

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
  end

  def destroy
    logout
  end
end