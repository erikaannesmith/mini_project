class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :location
      t.string :website
      t.string :company_name
      t.timestamps
    end
  end
end
