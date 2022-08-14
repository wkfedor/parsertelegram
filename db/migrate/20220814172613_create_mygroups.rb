class CreateMygroups < ActiveRecord::Migration[7.0]
  def change
    create_table :mygroups do |t|
      t.bigint :iid
      t.string :username
      t.string :title
      t.string :description
      t.integer :countuser
      t.datetime :datein

      t.timestamps
    end
  end
end
