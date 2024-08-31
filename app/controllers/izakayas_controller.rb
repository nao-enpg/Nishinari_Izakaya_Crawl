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

    # 現在地からの距離を計算して、10件取得する
    if params[:lat].present? && params[:lng].present?
      lat1 = params[:lat].to_f * Math::PI / 180
      lng1 = params[:lng].to_f * Math::PI / 180

      arounds = Izakaya.all.map do |izakaya|
        lat2 = izakaya.lat * Math::PI / 180
        lng2 = izakaya.lng * Math::PI / 180

        diff_y = (lng1 - lng2).abs
        calc1 = Math.cos(lat2) * Math.sin(diff_y)
        calc2 = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(diff_y)

        numerator = Math.sqrt(calc1 ** 2 + calc2 ** 2)
        denominator = Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(diff_y)
        degree = Math.atan2(numerator, denominator)

        α = 6378.137
        distance = degree * α

        { izakaya: izakaya, distance: distance }
      end

      @izakayas = arounds.sort_by { |h| h[:distance] }.first(10).map { |h| h[:izakaya] }
    else
      @izakayas = @q.result(distinct: true).includes(:tags, :favorites).order(id: :asc)
    end

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
