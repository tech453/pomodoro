class MemosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:edit,:create]
  
  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = 'メモを作成しました'
      redirect_to root_url
    else
      @memos = current_user.memos.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メモの作成に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @memo=Memo.find(params[:id])
  end
  
  def update
    @memo=Memo.find(params[:id])
    if @memo.update(memo_params)
      flash[:success] = 'メモを更新しました'
      redirect_to root_url
    else
      flash.now[:danger] = 'メモの更新ができませんでした。'
      render :edit
    end
  end

  def destroy
    @memo.destroy
    flash[:success] = 'メモを削除しました。'
    redirect_to root_url
  end

  private

  def memo_params
    params.require(:memo).permit(:content)
  end

  def correct_user
    @memo = current_user.memos.find_by(id: params[:id])
    unless @memo
      redirect_to root_url
    end
  end
end
