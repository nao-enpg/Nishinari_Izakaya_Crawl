class IzakayasController < ApplicationController
  skip_before_action :require_login

  def index
    @tags = Tag.order(id: :asc).all
    selected_tags = params[:q] ? params[:q][:tags_id_all] : []

    if selected_tags.present?
      izakaya_ids = Izakaya.joins(:tags)
                           .where(tags: { id: selected_tags })
                           .group('izakayas.id')
                           .having('COUNT(tags.id) = ?', selected_tags.size)
                           .pluck(:id)
      @q = Izakaya.where(id: izakaya_ids).ransack(params[:q])
    else
      @q = Izakaya.ransack(params[:q])
    end

    @izakayas = @q.result(distinct: true).includes(:tags, :favorites).order(id: :asc)
    @plan_exists = current_user ? Plan.exists?(user_id: current_user.id) : false
  end

  def show
    @izakaya = Izakaya.find(params[:id])
    @tags = Tag.order(id: :asc).all
  end

  def favorites
    @q = current_user.favorites_izakayas.ransack(params[:q])
    @favorite_izakayas = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end
end
