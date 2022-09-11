class AddTmeToDopmygroups < ActiveRecord::Migration[7.0]
  def change
    add_column :dopmygroups, :tme, :integer
  end
end
