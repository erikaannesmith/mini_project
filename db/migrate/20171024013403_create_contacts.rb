class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :company
      t.string :contact_name
      t.string :location
      t.string :email
      t.string :phone_number
      t.string :industry

      t.timestamps
    end
  end
end
