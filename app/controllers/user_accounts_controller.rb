class UserAccountsController < ApplicationController
  before_filter :is_login?,:only => [:edit,:update,:show]
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "You will receive an email with instructions about how to confirm your account in a few minutes."
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
  def show
    @user = User.find params[:id]
    @followers = @user.followers.count
    @followings = @user.followings.count
    @fb = true if Authorization.exists?(:user_id => @user.id,:provider => 'facebook')
    @tw = true if Authorization.exists?(:user_id => @user.id,:provider => 'twitter')
    @tweet = Tweet.find_by_user_id_and_following_id(current_user.id,@user.id)
    if @tweet
      @follow = @tweet.follow
    else
      @follow = false
    end
  end
  
  def edit
    @user = current_user
    @fb = true if Authorization.exists?(:user_id => @user.id,:provider => 'facebook')
    @tw = true if Authorization.exists?(:user_id => @user.id,:provider => 'twitter')
  end
  
  def update
    @user = current_user
    @fb = true if Authorization.exists?(:user_id => @user.id,:provider => 'facebook')
    @tw = true if Authorization.exists?(:user_id => @user.id,:provider => 'twitter')
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render :action => :edit
    end
  end
  
  def change_password
    current_user.errors.add(:password, 'is required') if params[:user].nil? or params[:user][:password].to_s.blank?
    if current_user.errors.empty? and current_user.update_with_password(user_params)
      sign_in(:user, current_user, :bypass => true)
      flash.now[:notice] = "Your Password Changed Successfully."
    end
    respond_to do |format|
      format.js
    end
  end
  
  def follower
    @user = User.find params[:id]
    @tweet = Tweet.find_by_user_id_and_following_id(current_user.id,@user.id)
    if @tweet
      @tweet.update_attribute(:follow,params[:follow])
      @follow = @tweet.follow
    else
      @tweet = Tweet.create(:user_id => current_user.id,:following_id => @user.id,:follow => params[:follow])
      @follow = @tweet.follow
    end
    @followers = @user.followers.count
    @followings = @user.followings.count
    respond_to do |format|
      format.js
    end
  end
  
  private
  def user_params
    params.require(:user).permit!
  end
  
end
