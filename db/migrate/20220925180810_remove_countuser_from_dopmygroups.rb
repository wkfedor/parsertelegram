class RemoveCountuserFromDopmygroups < ActiveRecord::Migration[7.0]
  def change
    remove_column :dopmygroups, :countuser, :string
  end
end
