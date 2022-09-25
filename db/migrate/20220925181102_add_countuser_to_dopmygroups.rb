class AddCountuserToDopmygroups < ActiveRecord::Migration[7.0]
  def change
    add_column :dopmygroups, :countuser, :integer
  end
end
