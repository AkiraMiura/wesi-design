class RemoveNameFromData < ActiveRecord::Migration[5.1]
  def change
    remove_column :data, :name, :string
  end
end
