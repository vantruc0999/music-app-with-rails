class AddGenderAndBirthDayToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :gender, :integer, limit: 1
    add_column :users, :birth_day, :date
  end
end
