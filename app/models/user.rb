class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :posts

  def self.find_for_oauth(auth)
   user = User.where(uid: auth.uid, provider: auth.provider).first

   unless user
     create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.token = auth['credentials']['token']
      user.secret = auth['credentials']['secret']
      user.email = User.dummy_email(auth)
      user.password = Devise.friendly_token[0, 20]
    end
   end

   user
  end

  private

  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end
