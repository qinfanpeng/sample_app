# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_filter :require_sign_in, only: [:edit, :update, :index, :following, :followers]
  before_filter :only_youself, only: [:edit, :update]
  before_filter :require_admin, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])  # 因为在 only_youself中已经定义了 @user， 所有次行代码可以删去
  end

  def update
    @user = User.find(params[:id])  # 同理，次行代码也可删除
    if @user.update_attributes(params[:user])
      flash[:success] = "updated your profile"
      sign_in @user
      redirect_to @user
    else
      flash.now[:error] = "update fail"
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def only_youself
      @user = User.find(params[:id])
      redirect_to root_url, notice: "you can only edit your profile" unless current_user?(@user)
    end

    def require_admin
      redirect_to root_url, notice: "only admin can delete other user " unless current_user.admin?
    end
end
