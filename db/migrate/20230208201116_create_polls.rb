

class CreatePolls < ActiveRecord::Migration[7.0]
  def change
    create_table :polls do |t|
      t.string :question
      t.string :answer_one
      t.string :answer_two
      t.string :answer_three
      t.string :answer_four

      t.timestamps
    end
  end
end
