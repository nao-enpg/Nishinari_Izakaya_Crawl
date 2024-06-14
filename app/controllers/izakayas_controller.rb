class IzakayasController < ApplicationController
  skip_before_action :require_login

  def index
    @izakayas = Izakaya.order(id: :asc).all
    @tags = Tag.order(id: :asc).all
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
