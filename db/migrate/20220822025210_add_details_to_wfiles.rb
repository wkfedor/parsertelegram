class AddDetailsToWfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :wfiles, :myfile, :string
  end
end
