class AppConfig < ActiveRecord::Base
  validates :description, presence: true
  validates :permission, presence: true
  validates :title, presence: true

  def messageboards_count
    Messageboard.count
  end

  def posts_count
    Messageboard.all.inject(0){ |sum, item| sum + item.posts_count }
  end

  def topics_count
    Messageboard.all.inject(0){ |sum, item| sum + item.topics_count }
  end
end
