class DeleteUserTopicReadsDupes < ActiveRecord::Migration
  def up
    execute <<-eosql
      DELETE FROM thredded_user_topic_reads
      WHERE id IN (
        SELECT id FROM (
          SELECT id, row_number() OVER (partition BY user_id, topic_id ORDER BY id)
          AS rnum FROM thredded_user_topic_reads
        ) t WHERE t.rnum > 1
      )
    eosql
  end
end
