class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :animal, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.boolean :value

      t.timestamps null: false
    end
  end
end
