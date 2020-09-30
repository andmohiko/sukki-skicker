class SkickerUsersController < ApplicationController
  before_action :set_skicker_user, only: [:show, :update, :destroy]

  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      render json: { status: 'SUCCESS', message: 'Loaded users', value: @current_user.skickers.order(power: :desc) }
    else
      skicker_users = SkickerUser.all
      render json: { status: 'SUCCESS', message: 'Loaded skicker_users', value: skicker_users }
    end
  end

  def create
    @skicker_user = SkickerUser.new(skicker_user_params)
    if @skicker_user.save
      render json: { status: 'SUCCESS', message: 'Created skicker_user', value: @skicker_user }
    else
      render json: { status: 'ERROR', message: 'Failed to create skicker_user', value: @skicker_user.errors }
    end
  end

  def destroy
    if @skicker_user.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the skicker_user', data: @skicker_user }
    else
      render json: @skicker_user.errors, status: :unprocessable_entity
    end
  end

  private

  def set_skicker_user
    @skicker_user = SkickerUser.find(params[:id])
  end

  def skicker_user_params
    params.require(:skicker_user).permit(:user_id, :skicker_id)
  end
end
