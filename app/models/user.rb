class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :posts

  def self.find_for_oauth(auth)
   user = User.where(uid: auth.uid, provider: auth.provider).first

   unless user
     user = User.create(
       name:     auth.info.nickname,
       uid:      auth.uid,
       provider: auth.provider,
       token:    auth.credentials.token,
       secret:   auth.credentials.secret,
       email:    User.dummy_email(auth),
       password: Devise.friendly_token[0, 20]
     )
   end

   user
  end

  private

  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end
