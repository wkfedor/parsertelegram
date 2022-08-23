class RemoveMyfileFromWfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :wfiles, :myfile, :string
  end
end
