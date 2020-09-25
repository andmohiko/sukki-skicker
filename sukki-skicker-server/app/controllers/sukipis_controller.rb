class SukipisController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :set_sukipi, only: [:show, :update, :destroy]
  # protect_from_forgery with: :exception, only: :create

  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      render json: {
        status: 'SUCCESS',
        message: 'Loaded users',
        value: @current_user.sukipis
      }
    else
      sukipis = Sukipi.order(created_at: :desc)
      render json: { status: 'SUCCESS', message: 'Loaded sukipis', value: sukipis }
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded sukipi', data: @sukipi }
  end

  def create
    sukipi = Sukipi.new(sukipi_params)
    if sukipi.save
      render json: { status: 'SUCCESS', message: 'Created sukipi', data: sukipi }
    else
      render json: { status: 'ERROR', message: 'Failed to create sukipi', data: sukipi.errors }
    end
  end

  def update
    if @sukipi.update(sukipi_params)
      render json: { status: 'SUCCESS', message: 'Updated sukipi', data: @sukipi }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @sukipi.errors }
    end
  end

  def destroy
    @sukipi.destroy
    render json: { status: 'SUCCESS', message: 'Deleted sukipi', data: @sukipi }
  end

  private

  def set_sukipi
    @sukipi = Sukipi.find(params[:id])
  end

  def sukipi_params
    params.require(:sukipi).permit(:name, :suki, :user_id)
  end
end
