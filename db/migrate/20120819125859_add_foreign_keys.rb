class AddForeignKeys < ActiveRecord::Migration
  def change

    say_with_time "Deleting topics with no messageboard" do
      exec_delete <<-SQL
        DELETE FROM topics where messageboard_id in (select messageboard_id from topics EXCEPT select id from messageboards);
      SQL
    end

    say_with_time "Deleting topics with no posts" do
      exec_delete <<-SQL
        DELETE FROM topics WHERE id in (SELECT id FROM topics EXCEPT SELECT topic_id FROM posts);
      SQL
    end

    say_with_time "Deleting posts with no topic" do
      exec_delete <<-SQL
        DELETE FROM posts WHERE topic_id in (SELECT topic_id FROM posts EXCEPT SELECT id FROM topics);
      SQL
    end

    say_with_time "Deleting private users with no topics" do
      exec_delete <<-SQL
        DELETE FROM private_users WHERE private_topic_id in (SELECT private_topic_id FROM private_users EXCEPT SELECT id FROM topics);
      SQL
    end

    say_with_time "Deleting more private users with no topics" do 
      exec_delete <<-SQL
        DELETE FROM private_users WHERE private_topic_id in (SELECT id FROM topics EXCEPT SELECT private_topic_id FROM private_users);
      SQL
    end



    add_foreign_key "attachments", "posts", :name => "attachments_post_id_fk"
    add_foreign_key "categories", "messageboards", :name => "categories_messageboard_id_fk"
    add_foreign_key "messageboards", "sites", :name => "messageboards_site_id_fk"
    add_foreign_key "posts", "messageboards", :name => "posts_messageboard_id_fk"
    add_foreign_key "posts", "topics", :name => "posts_topic_id_fk"
    add_foreign_key "posts", "users", :name => "posts_user_id_fk"
    add_foreign_key "private_users", "topics", :name => "private_users_private_topic_id_fk", :column => "private_topic_id"
    add_foreign_key "private_users", "users", :name => "private_users_user_id_fk"
    add_foreign_key "roles", "messageboards", :name => "roles_messageboard_id_fk"
    add_foreign_key "roles", "users", :name => "roles_user_id_fk"
    add_foreign_key "sites", "users", :name => "sites_user_id_fk"
    add_foreign_key "topics", "categories", :name => "topics_category_id_fk"
    add_foreign_key "topics", "users", :name => "topics_last_user_id_fk", :column => "last_user_id"
    add_foreign_key "topics", "messageboards", :name => "topics_messageboard_id_fk"
    add_foreign_key "topics", "users", :name => "topics_user_id_fk"
  end
end
