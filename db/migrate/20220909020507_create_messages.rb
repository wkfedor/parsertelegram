class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :maintext
      t.text :user
      t.text :img
      t.integer :dopid
      t.references :mygroup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
