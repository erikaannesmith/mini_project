class AddDescriptionColumnToDesigns < ActiveRecord::Migration[5.1]
  def change
    add_column :designs, :description, :text
  end
end
