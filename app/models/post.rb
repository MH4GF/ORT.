class Post < ApplicationRecord
  validates :content, {presence: true}

  acts_as_taggable_on
  acts_as_taggable
end
