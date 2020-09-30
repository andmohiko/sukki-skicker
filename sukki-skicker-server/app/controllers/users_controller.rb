class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    if params[:uid]
      @current_user = User.find_by(uid: params[:uid])
      if @current_user
        render json: {
          status: 'SUCCESS',
          message: 'Loaded user',
          value: @current_user
        }
      else
        render json: {
          status: 'SUCCESS',
          message: 'User not found',
          value: ''
        }
      end
    else
      users = User.all
      render json: users
    end
  end

  def show
    render json: { status: 'SUCCESS', message: 'Loaded sukipi', data: @user }
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @skicker_user = SkickerUser.create(user_id: @user.id, skicker_id: 1)
      render json: { status: :created, message: 'Created user', value: { user: @user, skicker_user: @skicker_user } }
    else
      render json: { status: :unprocessable_entity, message: 'Created user', value: { user: @user.errors, skicker_user: @skicker_user.errors } }
    end
  end

  def destroy
    if @user.destroy
      render json: { status: 'SUCCESS', message: 'Deleted the user', data: @user }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :uid, { :skicker_ids=> [] })
  end
end
