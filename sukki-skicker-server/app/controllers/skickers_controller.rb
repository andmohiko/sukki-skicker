class SkickersController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_skicker, only: [:show, :update, :destroy]
  # protect_from_forgery with: :exception, only: :create

  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      render json: {
        status: 'SUCCESS',
        message: 'Loaded users skickers',
        value: @current_user.skickers
      }
    else
      skickers = Skicker.order(created_at: :desc)
      render json: { status: 'SUCCESS', message: 'Loaded skickers', value: skickers }
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded skicker', data: @skicker }
  end

  def create
    skicker = Skicker.new(skicker_params)
    if skicker.save
      render json: { status: 'SUCCESS', data: skicker }
    else
      render json: { status: 'ERROR', data: skicker.errors }
    end
  end

  def destroy
    @skicker.destroy
    render json: { status: 'SUCCESS', message: 'Deleted skicker', data: @skicker }
  end

  private

    def set_skicker
      @skicker = Skicker.find(params[:id])
    end

    def skicker_params
      params.require(:skicker).permit(:name, :user_id)
    end
end
