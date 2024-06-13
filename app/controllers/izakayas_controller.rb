class IzakayasController < ApplicationController
  skip_before_action :require_login

  def index
    @izakayas = Izakaya.order(id: :asc).all
  end

  def show
    @izakaya = Izakaya.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
