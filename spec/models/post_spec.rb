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


require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe '#update_user_total_running_time' do
    subject { -> { create(:post, user: user) } }

    context 'Postがsaveされた時' do
      it '親のUserのtotal_running_timeが更新される' do
        is_expected.to change { user.total_running_time['total_min'] }.from('25').to('50')
      end
    end
  end
end
