require 'rails_helper'

feature 'Twitter認証' do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      'uid'       => '123',
      'provider'  => 'twitter',
      'info'      => { 
          'nickname' => 'anonymous'
      },
      'credentials' => {
          'token'   => 'example_token',
          'secret'  => 'example_seceret_token'
      }
    })
    user = FactoryBot.create(:user)
  end

  after do
    OmniAuth.config.test_mode = false
  end

  scenario 'ログインすることができる' do
    visit user_twitter_omniauth_authorize_path
    expect(page).to have_content 'Twitter アカウントによる認証に成功しました。'
  end

end
