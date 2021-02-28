class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit]
  before_action :set_user, only: [:edit,:update]
  def edit
    
  end

  def new
    @user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      session[:user_id] = @user.id
      redirect_to edit_user_path(@user)
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def update
    
    if @user.update(timer_params)
      flash[:success] = 'タイマを設定できました。頑張りましょう。'
      redirect_to root_path
    else
      flash[:success] = '各項目には、1~60の値を入力してください。'
      render :edit
    end
  end
  
  private
  
  def set_user
    @user=User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def timer_params
    params.require(:user).permit(:work, :short_break, :long_break)
  end
end
