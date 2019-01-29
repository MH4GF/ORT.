# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Users', type: :request do

  describe 'GET /users/mypage' do
    context 'ログインしていない場合' do
      it 'aboutページにリダイレクトされ、302を返す' do
        get '/users/mypage'
        expect(response).to have_http_status 302
      end
    end
    context 'ログインしている場合' do
      login
      it '200を返す' do
        get '/users/mypage'
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'GET /users/edit' do
    login
    it '200を返す' do
      get '/users/edit'
      expect(response).to have_http_status 200
    end
  end

  describe 'DELETE /users/destroy' do
    login
    it '302を返す' do
      delete '/users/destroy'
      expect(response).to have_http_status 302
    end
  end
end
