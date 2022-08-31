class CreateTwoloadfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :twoloadfiles do |t|
      t.string :lfilename
      t.string :comment

      t.timestamps
    end
  end
end
