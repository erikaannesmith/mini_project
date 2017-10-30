class RemoveImageColumnsFromDesign < ActiveRecord::Migration[5.1]
  def change
    remove_column :designs, :image_file_name
    remove_column :designs, :image_content_type
    remove_column :designs, :image_file_size
    remove_column :designs, :image_updated_at
  end
end
