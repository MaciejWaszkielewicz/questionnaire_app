class CreateJoinTableAnswersOptions < ActiveRecord::Migration[6.1]
  def change
    create_join_table :answers, :options do |t|
      t.index [:answer_id, :option_id]
      # t.index [:option_id, :answer_id]
    end
  end
end
