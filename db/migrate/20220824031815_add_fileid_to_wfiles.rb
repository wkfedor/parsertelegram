class AddFileidToWfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :wfiles, :fileid, :integer
  end
end
