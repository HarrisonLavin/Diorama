class TwitterApi
 attr_accessor :client

 def initialize
   keys = YAML.load_file('./config/secrets.yml')
   @client = Twitter::REST::Client.new do |config|
     config.consumer_key        = keys['CONSUMER_KEY']
     config.consumer_secret     = keys['CONSUMER_SECRET']
     config.access_token        = keys['ACCESS_TOKEN']
     config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
   end
 end

 def user_tweets(user, count)
   tweets = @client.user_timeline(user, options={count: count})
   tweets.each {|tweet| puts "#{tweet.text}\n\n"}
 end

 # def created_at
 #    tweet= self.Twitter::created_at
 # end

  def parse_tweet(tweet)
    #takes the info for the tweet from the API itself, then saves it to db
    date = tweet.created_at.to_datetime
    text= tweet.text
    user_name = tweet.user.name
    user_handle = tweet.user.screen_name
    tweet= Tweet.new(date: date, text: text, user_name: user_name, user_handle: user_handle)
  end

end