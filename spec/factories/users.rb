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

FactoryBot.define do
  factory :user do
    email     { 'test@example.com' }
    password  { 'password' }
    uid       { '123' }
    provider  { 'twitter' }
    name      { 'anonymous' }
  end
end
