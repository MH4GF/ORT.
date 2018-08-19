# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  uid                    :string
#  provider               :string
#  name                   :string
#  token                  :string
#  secret                 :string
#  default_time           :integer          default(25)
#  allow_linked_tweet     :boolean          default(TRUE), not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :posts, :dependent => :delete_all

  validates :default_time, numericality: {:less_than_or_equal_to => 99}

  def self.find_for_oauth(auth)
   user = User.where(uid: auth.uid, provider: auth.provider).first

   unless user
     create! do |user|
      user.provider  = auth['provider']
      user.uid       = auth['uid']
      user.name      = auth['info']['nickname']
      user.token     = auth['credentials']['token']
      user.secret    = auth['credentials']['secret']
      user.email     = User.dummy_email(auth)
      user.password  = Devise.friendly_token[0, 20]
    end
   end

   user
  end

  private

  def self.dummy_email(auth)
   "#{auth.uid}-#{auth.provider}@example.com"
  end
end
