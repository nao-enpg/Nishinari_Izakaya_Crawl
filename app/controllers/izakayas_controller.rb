class IzakayasController < ApplicationController
  skip_before_action :require_login

  def index
    @q = Izakaya.ransack(params[:q])
    @izakayas = @q.result(distinct: true).includes(:tags).order(id: :asc)
    @tags = Tag.order(id: :asc).all

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @izakaya = Izakaya.find(params[:id])
    @tags = Tag.order(id: :asc).all
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
