# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id           :bigint(8)        not null, primary key
#  content      :text
#  running_time :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#


FactoryBot.define do
  factory :post do
    running_time { 25 }
    content { '作業しました' }
  end
end
