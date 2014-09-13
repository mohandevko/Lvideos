class SocialAccountsController < Devise::OmniauthCallbacksController
  
  def create
    auth = request.env['omniauth.auth']
    if current_user
      @auth = Authorization.find_by_user_id_and_provider_and_uid(current_user.id,auth["provider"],auth["uid"])
      if @auth
        @auth.token = auth['credentials']['secret']
        @auth.secret_key = auth['credentials']['token']
        @auth.save
      else
        if auth["provider"] == 'twitter'
          current_user.t_connected = true
        elsif auth["provider"] == 'facebook'
          current_user.f_connected = true
        end
        current_user.save(:validate => false)
        auth = Authorization.new(:user_id => current_user.id,:provider => auth["provider"],:uid => auth["uid"],:token => auth['credentials']['token'],:secret_key => auth['credentials']['secret'])
        auth.save
      end
      redirect_to edit_user_account_path(current_user)
    else
      @user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])
      if @user
        user = @user
        @auth = Authorization.find_by_user_id_and_provider_and_uid(@user.id,@user.provider,@user.uid)
        @auth.token = auth['credentials']['secret']
        @auth.secret_key = auth['credentials']['token']
        @auth.save
      else
        user = User.new(:email => auth["provider"] == 'twitter' ? auth["extra"]["raw_info"]["screen_name"] : auth["extra"]["raw_info"]["email"],:username => auth['provider'] == 'twitter' ? auth["extra"]["raw_info"]["screen_name"] : auth["extra"]["raw_info"]["username"],:provider => auth['provider'],:uid => auth['uid'])
        if auth["provider"] == 'twitter'
          user.t_connected = true
        elsif auth["provider"] == 'facebook'
          user.f_connected = true
        end
        user.save(:validate => false)
        auth = Authorization.new(:user_id => user.id,:provider => user.provider,:uid => user.uid,:token => auth['credentials']['token'],:secret_key => auth['credentials']['secret'])
        auth.save
      end
      unless user.confirmed?
        user.confirm!
      end
      sign_in(user, :bypass => true)
      redirect_to root_path
    end
  end
  
  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
  
end
