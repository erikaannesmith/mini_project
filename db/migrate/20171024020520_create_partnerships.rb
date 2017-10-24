class CreatePartnerships < ActiveRecord::Migration[5.1]
  def change
    create_table :partnerships do |t|
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: true
    end
  end
end
