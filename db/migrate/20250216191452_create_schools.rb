class CreateSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
