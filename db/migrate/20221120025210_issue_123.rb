class Issue123 < ActiveRecord::Migration[7.0]
  def change
    rename_column  :messages, :maintext, :messages
    rename_column  :messages, :user, :usernametext
    add_column :messages, :usernamelink, :string
    add_column :messages, :videoimg, :string
    add_column :messages, :otvet, :string
    add_column :messages, :date, :datetime
    add_column :messages, :look, :integer

  end
end