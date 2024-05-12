class ChangeForeignKeys < ActiveRecord::Migration[7.1]
  def change
    change_table :watches do |w|
      w.belongs_to :user, null: false, foreign_key: true
    end
  end
end
