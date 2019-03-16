# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  allow_linked_tweet     :boolean          default(TRUE), not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  default_time           :integer          default(25)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string           not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  secret                 :string
#  sign_in_count          :integer          default(0), not null
#  token                  :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :posts, dependent: :delete_all

  validates :allow_linked_tweet, presence: true
  validates :default_time, presence: true, numericality: { less_than_or_equal_to: 99 }
  validates :email, uniqueness: true

  def self.find_for_oauth(auth)
    User.find_by(uid: auth.uid, provider: auth.provider) || User.create_by(auth)
  end

  def self.create_by(auth)
    user = User.create(
      provider:  auth['provider'],
      uid:       auth['uid'],
      name:      auth['info']['nickname'],
      token:     auth['credentials']['token'],
      secret:    auth['credentials']['secret'],
      email:     User.dummy_email(auth),
      password:  Devise.friendly_token[0, 20]
    )

    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def total_running_time
    running_time = get_total_running_time
    running_time.presence || set_total_running_time
  end

  def set_total_running_time
    running_time = SumRunningTimeService.new(posts).call
    REDIS.mapped_hmset(running_time_key, running_time)

    get_total_running_time
  end

  private

  def get_total_running_time
    REDIS.hgetall(running_time_key)
  end

  def running_time_key
    "#{self.id}-running-time"
  end
end
