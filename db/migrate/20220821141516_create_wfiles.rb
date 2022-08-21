class CreateWfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :wfiles do |t|
      t.string :word
      t.string :flag
      t.datetime :dateold

      t.timestamps
    end
  end
end
