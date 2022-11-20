class Issue124 < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :error, :string
  end
end