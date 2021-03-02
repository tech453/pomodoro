class MemosController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_memo,only: [:edit,:update,:destroy]
  
  
  def edit
    
  end
  
  def update
    if @memo.update(memo_params)
      flash[:success] = 'メモを更新しました。'
      redirect_to root_url
    else
      @memos = current_user.memos.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メモの更新に失敗しました。'
      render 'edit'
    end
  end
  def create
    @memo = current_user.memos.build(memo_params)
    if @memo.save
      flash[:success] = 'メモを作成しました。'
      redirect_to root_url
    else
      @memos = current_user.memos.order(id: :desc).page(params[:page])
      flash[:danger] = 'メモの作成に失敗しました。'
      redirect_to root_url
    end
  end

  def destroy
    @memo.destroy
    flash[:success] = 'メモを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  
  def set_memo
    @memo=Memo.find(params[:id])
  end

  def memo_params
    params.require(:memo).permit(:content)
  end

end
