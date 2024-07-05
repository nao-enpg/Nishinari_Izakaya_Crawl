class IzakayasController < ApplicationController
  skip_before_action :require_login

  def index
    @q = Izakaya.ransack(params[:q])
    @izakayas = @q.result(distinct: true).includes(:tags, :favorites).order(id: :asc)
    @tags = Tag.order(id: :asc).all
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
