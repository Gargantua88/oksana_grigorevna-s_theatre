class PerfomancesController < ApplicationController
  before_action :set_perfomance, only: [:destroy]

  def index
    @perfomances = Perfomance.all

    render json: @perfomances
  end

  def create
    @perfomance = Perfomance.new(perfomance_params)

    if @perfomance.save
      render json: @perfomance, status: :created
    else
      render json: @perfomance.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @perfomance.destroy
  end

  private

  def set_perfomance
    @perfomance = Perfomance.find(params[:id])
  end

  def perfomance_params
    params.fetch(:perfomance, {}).permit(:title, :start_date, :finish_date)
  end
end
