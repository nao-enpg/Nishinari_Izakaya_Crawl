class IzakayaPlansController < ApplicationController
  before_action :require_login
  before_action :set_izakaya_plan, only: [:destroy]

  def create
    @izakaya_plan = IzakayaPlan.new(izakaya_plan_params)

    if @izakaya_plan.save
      redirect_to plan_path(@izakaya_plan.plan), notice: '旅程表に追加しました。'
    else
      redirect_to izakayas_path, alert: '追加に失敗しました。'
    end
  end

  def destroy
    @izakaya_plan.destroy!
    redirect_to plan_path(@plan), notice: '旅程表から削除しました。', status: :see_other
  end

  private

  def set_izakaya_plan
    @izakaya_plan = IzakayaPlan.find(params[:id])
    @plan = @izakaya_plan.plan
  end

  def izakaya_plan_params
    params.require(:izakaya_plan).permit(:izakaya_id, :plan_id)
  end
end
