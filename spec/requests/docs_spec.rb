# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Docs', type: :request do

  describe 'GET /' do
    it '200を返す' do
      get '/'
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /about' do
    it '200を返す' do
      get '/about'
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /contact' do
    it '200を返す' do
      get '/contact'
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /terms' do
    it '200を返す' do
      get '/terms'
      expect(response).to have_http_status 200
    end
  end
  describe 'GET /privacy' do
    it '200を返す' do
      get '/privacy'
      expect(response).to have_http_status 200
    end
  end
end
