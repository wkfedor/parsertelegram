class CreateDopmygroups < ActiveRecord::Migration[7.0]
  def change
    create_table :dopmygroups do |t|
      t.string :countuser
      t.string :comment
      t.belongs_to :mygroup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
