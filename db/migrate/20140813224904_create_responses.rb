class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :question_id, :integer
      t.column :description, :string
    end
  end
end
