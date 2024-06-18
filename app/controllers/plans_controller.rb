class PlansController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_plan, only: %i[show edit update destroy]

  def index
    @plans = Plan.includes(:izakayas)
  end

  def show
    @izakayas = @plan.izakayas
    @izakaya_plan = IzakayaPlan.find_by(plan: @plan)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user

    if @plan.save
      redirect_to @plan, notice: '旅程表を作成しました'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: '更新しました'
    else
      render :edit
    end
  end

  def destroy
    @plan.destroy!
    redirect_to plans_path, success: '削除しました', status: :see_other
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :public)
  end
end
