class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :joining_date, :date
    add_column :users, :phone_number, :string
    add_column :users, :address, :string
    add_column :users, :pincode, :string
    add_column :users, :latest_degree, :string
    add_column :users, :role, :string, default: 'user'
  end
end
