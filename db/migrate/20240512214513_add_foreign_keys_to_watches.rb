class AddForeignKeysToWatches < ActiveRecord::Migration[7.1]
  def change_table
    watches.belongs_to :user, null:false, foreign_key:true
  end
end
