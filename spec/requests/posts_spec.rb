# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Posts', type: :request do

  let(:params) do
    {
      post: {
        running_time: 25,
        tag_list: 'Rails',
        content: 'めちゃんこ勉強した！'
      }
    }
  end
  describe 'GET /posts/new' do
    login
    it '200を返す' do
      get '/posts/new'
      expect(response).to have_http_status 200
    end
  end
  describe 'POST /posts' do
    login
    it '302を返す' do
      post '/posts', params: params
      expect(response).to have_http_status 302
    end
  end
  describe 'GET /posts/:id' do
    login
    let(:post) { create(:post, user: user) }
    it '200を返す' do
      get "/posts/#{post.id}"
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /posts/:id/edit' do
    login
    let(:post) { create(:post, user: user) }
    it '200を返す' do
      get "/posts/#{post.id}/edit"
      expect(response).to have_http_status 200
    end
  end
  describe 'PUT /posts/:id' do
    login
    let(:post) { create(:post, user: user) }
    it '302を返す' do
      put "/posts/#{post.id}", params: params
      expect(response).to have_http_status 302
    end
  end
  describe 'DELETE /posts/:id' do
    login
    let(:post) { create(:post, user: user) }
    it '302を返す' do
      delete "/posts/#{post.id}", params: params
      expect(response).to have_http_status 302
    end
  end
end
