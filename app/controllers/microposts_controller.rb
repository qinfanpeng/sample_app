class MicropostsController < ApplicationController
  before_filter :require_sign_in, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  def index
  end

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_url
  end

  private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_url, notice: "you can't delete other's micropots" if @micropost.nil?
    end
end
