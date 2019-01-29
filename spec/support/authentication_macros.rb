# frozen_string_literal: true

module AuthenticationMacros
  def login
    let(:user) { build(:user) }
    before do
      sign_in user
    end
  end
end
