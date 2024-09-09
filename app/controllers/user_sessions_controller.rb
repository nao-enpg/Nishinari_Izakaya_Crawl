class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create destroy]
  def new; end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to root_path, success: t('user_sessions.login_success')
    else
      flash.now[:danger] = t('user_sessions.login_failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:success] = t('user_sessions.logout_success')
    redirect_to root_path, status: :see_other
  end
end
