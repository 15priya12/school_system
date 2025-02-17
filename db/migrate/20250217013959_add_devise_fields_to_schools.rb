class AddDeviseFieldsToSchools < ActiveRecord::Migration[6.0]
  def change
    change_table :schools, bulk: true do |t|
      t.string :email, default: "", null: false unless column_exists?(:schools, :email)
      t.string :encrypted_password, null: false, default: "" unless column_exists?(:schools, :encrypted_password)
      t.string :reset_password_token unless column_exists?(:schools, :reset_password_token)
      t.datetime :remember_created_at unless column_exists?(:schools, :remember_created_at)
    end

    add_index :schools, :email, unique: true unless index_exists?(:schools, :email)
    add_index :schools, :reset_password_token, unique: true unless index_exists?(:schools, :reset_password_token)
  end
end
