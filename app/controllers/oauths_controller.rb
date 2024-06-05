class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if (@user = login_from(provider))
      redirect_to root_path, notice: 'Googleアカウントでログインしました'
    else
      begin
        signup_and_login(provider)
        redirect_to root_path, notice: 'Googleアカウントでログインしました'
      rescue StandardError => e
        Rails.logger.error("OAuth login failed: #{e.message}")
        redirect_to root_path, alert: 'Googleアカウントでのログインに失敗しました'
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :scope, :authuser, :prompt)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
    # rescue StandardError => e
    #  Rails.logger.error("User creation failed: #{e.message}")
    #  raise
  end
end
