class IzakayasController < ApplicationController
  skip_before_action :require_login

  def index
    @izakayas = Izakaya.order(id: :asc).all
  end
end