get '/' do
  erb :index
end


get '/:username' do
  @user = User.find_or_create_by_username(params[:username])


  if @user.tweets.empty?
    @user.fetch_tweets!
  end
  
  if @user.tweets.empty?
    @error = "Either this user does not exist or they do not have any tweets."
    erb :tweets
  elsif @user.tweets_stale?
    @user.fetch_tweets!
  end


  @tweets = @user.tweets.order("twitter_id DESC").limit(10)
  erb :tweets
end
