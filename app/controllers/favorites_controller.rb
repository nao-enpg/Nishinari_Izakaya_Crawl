class FavoritesController < ApplicationController
  before_action :set_izakaya

  def create
    favorite = @izakaya.favorites.new(user: current_user)
    if favorite.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @izakaya, notice: 'お気に入りに追加しました' }
      end
    else
      redirect_to @izakaya, alert: 'お気に入りに追加できませんでした'
    end
  end

  def destroy
    favorite = @izakaya.favorites.find_by(user: current_user)
    favorite.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @izakaya, notice: 'お気に入りを削除しました' }
    end
  end

  private

  def set_izakaya
    @izakaya = Izakaya.find(params[:izakaya_id])
  end
end
