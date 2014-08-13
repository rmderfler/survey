class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.column :question_id, :integer
      t.column :choice, :string
    end
  end
end
