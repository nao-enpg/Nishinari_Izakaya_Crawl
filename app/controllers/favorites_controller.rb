class FavoritesController < ApplicationController
  def create
    @izakaya = Izakaya.find(params[:izakaya_id])
    current_user.favorite(@izakaya)

    respond_to do |format|
      format.html { redirect_to izakayas_path }
      format.turbo_stream
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    if favorite
      @izakaya = favorite.izakaya
      current_user.unfavorite(@izakaya)

      respond_to do |format|
        format.html { redirect_to izakayas_path, status: :see_other }
        format.turbo_stream
      end
    else
      redirect_to izakayas_path, alert: 'Favorite not found'
    end
  end
end
