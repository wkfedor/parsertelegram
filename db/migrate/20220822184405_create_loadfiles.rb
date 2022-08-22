class CreateLoadfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :loadfiles do |t|
      t.string :lfilename
      t.string :comment

      t.timestamps
    end
  end
end
