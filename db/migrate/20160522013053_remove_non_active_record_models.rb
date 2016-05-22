class RemoveNonActiveRecordModels < ActiveRecord::Migration
  def change
    drop_table :foods
    drop_table :musics
  end
end
