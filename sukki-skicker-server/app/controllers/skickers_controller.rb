class SkickersController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_skicker, only: [:show, :update, :destroy]
  # protect_from_forgery with: :exception, only: :create

  def index
    skickers = Skicker.order(power: :asc)
    render json: { status: 'SUCCESS', message: 'Loaded skickers', value: skickers }
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded skicker', value: @skicker }
  end

  def create
    skicker = Skicker.new(skicker_params)
    if skicker.save
      render json: { status: 'SUCCESS', message: 'Created skicker', data: skicker }
    else
      render json: { status: 'ERROR', message: 'Failed to create skicker', data: skicker.errors }
    end
  end

  def update
    if @skicker.update(skicker_params)
      render json: { status: 'SUCCESS', message: 'Updated skicker', data: @skicker }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @skicker.errors }
    end
  end

  private

  def set_skicker
    @skicker = Skicker.find(params[:id])
  end

  def skicker_params
    params.require(:skicker).permit(:name, :power, :cost)
  end
end
