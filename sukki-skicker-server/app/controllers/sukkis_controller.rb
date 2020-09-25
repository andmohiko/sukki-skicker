class SukkisController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_sukki, only: [:show, :update, :destroy]
  # protect_from_forgery with: :exception, only: :create

  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      render json: {
        status: 'SUCCESS',
        message: 'Loaded users sukkis',
        value: @current_user.sukkis
      }
    else
      sukkis = Sukki.order(created_at: :desc)
      render json: { status: 'SUCCESS', message: 'Loaded sukkis', value: sukkis }
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded skicker', data: @sukki }
  end

  def create
    sukki = Sukki.new(sukki_params)
    if sukki.save
      render json: { status: 'SUCCESS', data: sukki }
    else
      render json: { status: 'ERROR', data: sukki.errors }
    end
  end

  def update
    if @sukki.update(sukki_params)
      render json: { status: 'SUCCESS', message: 'Updated sukki', data: @sukki }
    else
      render json: { status: 'SUCCESS', message: 'Failed updating', data: @sukki.errors }
    end
  end

  private

    def set_sukki
      @sukki = Sukki.find(params[:id])
    end

    def sukki_params
      params.require(:sukki).permit(:suki, :user_id, :skicker_id)
    end
end
