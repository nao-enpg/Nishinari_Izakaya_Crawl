class PlansController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
  before_action :set_plan, only: %i[show edit update destroy]

  def index
    @plans = Plan.includes(:izakayas).where(public: true).or(Plan.where(user: current_user))
  end

  def show
    @plan = Plan.find(params[:id])
    unless current_user&.own?(@plan) || @plan.public?
      redirect_to plans_path, alert: t('.plans.public_false')
    end
    @izakayas = @plan.izakayas.joins(:izakaya_plans).merge(IzakayaPlan.rank(:row_order))
    @izakaya_plan = IzakayaPlan.find_by(plan: @plan)

    set_meta_tags({
      title: '西成泥酔旅行',
      og: {
        title: '西成泥酔旅行',
        url: request.original_url,
      }
    })
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user = current_user

    if @plan.save
      redirect_to @plan, notice: t('.success')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @plan.update(plan_params)
      redirect_to @plan, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @plan.destroy!
    redirect_to plans_path, success: t('.success'), status: :see_other
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:name, :public, :description)
  end
end
