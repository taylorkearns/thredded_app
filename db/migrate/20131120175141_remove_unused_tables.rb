class RemoveUnusedTables < ActiveRecord::Migration
  def change
    drop_table :sessions
    drop_table :new_thredded_attachments
    drop_table :new_thredded_categories
    drop_table :new_thredded_images
    drop_table :new_thredded_messageboard_preferences
    drop_table :new_thredded_messageboards
    drop_table :new_thredded_post_notifications
    drop_table :new_thredded_posts
    drop_table :new_thredded_private_users
    drop_table :new_thredded_roles
    drop_table :new_thredded_topic_categories
    drop_table :new_thredded_topics
    drop_table :new_thredded_user_topic_reads
  end
end
