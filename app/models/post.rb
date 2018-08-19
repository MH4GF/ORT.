# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content      :text
#  running_time :integer
#  user_id      :integer
#

class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  acts_as_taggable

  def tweet
    client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret      = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token         = user.token
      config.access_token_secret  = user.secret
    end
    # Twitter投稿
    client.update(tweet_contents)
  end

  # ツイート内容
  def tweet_contents
    "#{content} 【#{running_time}分】#インターネット勉強班 @ORT_pomodoro"
  end
end