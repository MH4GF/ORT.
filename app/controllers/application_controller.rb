class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :tags

  def tags
    @all_tags = ActsAsTaggableOn::Tag.all
  end
end
