class RenameReseacherNameColumnToData < ActiveRecord::Migration[5.1]
  def change
    rename_column :data, :reseacher_name, :researcher_name
  end
end
