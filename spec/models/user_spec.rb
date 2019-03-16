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

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe '#total_running_time' do
    subject { user.total_running_time['total_min'] }

    context 'Redisにキャッシュが存在している場合' do
      it '値を返す' do
        is_expected.to eq '25'
      end
    end
    context 'Redisにキャッシュが存在しない場合' do
      before { REDIS.flushdb }
      it '値を返す(合計時間を計算し、キャッシュに保存する)' do
        is_expected.to eq '25'
      end
    end
  end

  describe '#set_total_running_time_to_redis' do
    subject { -> { user.set_total_running_time_to_redis } }
    before { REDIS.flushdb }
    it 'ユーザーの合計学習時間をRedisに保存する' do
      is_expected.to change { REDIS.data.size }.by(1)
    end
  end
end
