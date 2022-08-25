class AddCaptionToMygroups < ActiveRecord::Migration[7.0]
  def change
    add_column :mygroups, :caption, :string
  end
end
