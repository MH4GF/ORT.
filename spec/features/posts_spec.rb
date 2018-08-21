require 'rails_helper'

feature '投稿する' do
  let(:user) { FactoryBot.create(:user) }

  context '時間、タグ、内容を入力し、同時ツイートはオフの場合' do
    scenario '「投稿を作成しました。5分休憩しましょう！」と表示される' do
      login_as user
      visit new_post_path

      select  '25分', match: :first
      fill_in 'post[tag_list]', with: 'tag'
      fill_in 'post[content]', with: '学習内容'
      uncheck 'switch'

      click_button '投稿'

      expect(page).to have_content '投稿を作成しました。5分休憩しましょう！'
    end
  end

  context '内容が未入力の場合' do
    scenario '「作業内容を入力してください」と表示される' do
      login_as user
      visit new_post_path

      select  '25分', match: :first
      fill_in 'post[tag_list]', with: 'tag'
      fill_in 'post[content]', with: nil
      uncheck 'switch'

      click_button '投稿'

      expect(page).to have_content '作業内容を入力してください'
    end
  end

  # context '内容を入力し、同時ツイートがオンの場合' do
  #   scenario '「投稿とツイートが完了しました。5分休憩しましょう！」と表示される' do
  #     login_as user
  #     visit new_post_path

  #     fill_in 'post[content]', with: '学習内容'
  #     check 'switch'

  #     twitter_client_mock = double('Twitter client')
  #     expect(twitter_client_mock).to receive(:update)
  #     allow(@post).to receive(:twitter_client).and_return(twitter_client_mock)
  #     click_button '投稿'

  #     expect(page).to have_content '投稿とツイートが完了しました。5分休憩しましょう！' 
  #   end
  # end

end