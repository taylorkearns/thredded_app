class Category < ActiveRecord::Base
  validates_presence_of :name, :description

  has_many :topic_categories
  has_many :topics, through: :topic_categories

  belongs_to :messageboard
end
