class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def edit
    render layout: false if turbo_frame_request?
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to profile_path, success: 'プロフィールを更新しました' }
        format.turbo_stream { flash.now[:success] = 'プロフィールを更新しました' }
      end
    else
      flash.now['danger'] = 'プロフィールの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @favorites = @user.favorites
    @plans = @user.plans
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
